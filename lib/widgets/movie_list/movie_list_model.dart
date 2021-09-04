import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class MovieListModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _movies = <Movie>[];
  List<Movie> get movies => List.unmodifiable(_movies);
  late DateFormat _dateFormat;
  late int _currentPage;
  late int _totalPages;
  var _isLoadingInProgress = false;
  String _locale = '';
  Timer? searchDebounce;
  String? _searchQuery;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  void setupLocale(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    _currentPage = 0;
    _totalPages = 1;
    _movies.clear();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    if (_isLoadingInProgress || _currentPage >= _totalPages) return;
    _isLoadingInProgress = true;

    final nextPage = _currentPage + 1;
    // final moviesResponce = await _apiClient.popularMovie(nextPage, _locale);
    try {
      final moviesResponce = await _apiClient.popularMovie(nextPage, 'ru-RU');
      _movies.addAll(moviesResponce.movies);
      _isLoadingInProgress = false;
      _currentPage = moviesResponce.page;
      _totalPages = moviesResponce.totalPages;
      notifyListeners();
    } catch (e) {
      _isLoadingInProgress = false;
    }
  }

  Future<void> searchMovies(String query) async {
    searchDebounce?.cancel();
    searchDebounce = Timer(const Duration(seconds: 1), () async {
      final searchQuery = query.isNotEmpty ? query : null;
      if (searchQuery == null) return;
      if (_searchQuery == searchQuery) return;
      _searchQuery = searchQuery;

      if (_isLoadingInProgress) return;
      _isLoadingInProgress = true;

      final nextPage = 1;
      try {
        final moviesResponce =
            await _apiClient.searchMovie(nextPage, 'ru-RU', searchQuery);
        _movies.clear();
        _movies.addAll(moviesResponce.movies);
        _isLoadingInProgress = false;
        _currentPage = moviesResponce.page;
        _totalPages = moviesResponce.totalPages;
        notifyListeners();
      } catch (e) {
        _isLoadingInProgress = false;
      }
    });
  }

  Future<void> minApiTest() async {
    final minApiResponce = await _apiClient.minimalApiGet();
    print(minApiResponce);
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context)
        .pushNamed(MainNavigationRouteNames.movieDetails, arguments: id);
  }

  void showedMovieAtIndex(int index) {
    if (index < _movies.length - 1) return;
    _loadMovies();
  }
}
