import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';
//import 'package:themoviedb/library/widgets/inherited/provider.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _sessionDataProvider = SessionDataProvider();
  final _apiClient = ApiClient();
  bool _isFavorite = false;
  final int movieId;
  String _locale = '';
  late DateFormat _dateFormat;
  MovieDetails? _movieDetails;

  MovieDetails? get movieDetails => _movieDetails;
  bool get isFavorite => _isFavorite;
  MovieDetailsModel({
    required this.movieId,
  });

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    await loadDetails();
  }

  Future<void> loadDetails() async {
    _movieDetails = await _apiClient.movieDetails(movieId, 'ru-RU');
    final sessionId = await _sessionDataProvider.getSessionId();
    if (sessionId != null) {
      _isFavorite = await _apiClient.isFavorite(sessionId, movieId);
    }
    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final accountId = await _sessionDataProvider.getAccountId();
    if (sessionId == null || accountId == null) return;

    _isFavorite = !_isFavorite;
    _apiClient.markAsFavorite(
      accountId: accountId,
      sessionId: sessionId,
      mediaType: MediaType.movie,
      mediaId: movieId,
      isFavorite: _isFavorite,
    );

    notifyListeners();
  }
}
