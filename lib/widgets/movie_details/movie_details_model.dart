import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';
//import 'package:themoviedb/library/widgets/inherited/provider.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final int movieId;
  String _locale = '';
  late DateFormat _dateFormat;
  MovieDetails? _movieDetails;

  MovieDetails? get movieDetails => _movieDetails;

  MovieDetailsModel({
    required this.movieId,
  });

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await loadDetails();
  }

  Future<void> loadDetails() async {
    _movieDetails = await _apiClient.movieDetails(movieId, 'ru-RU');
    notifyListeners();
  }
}
