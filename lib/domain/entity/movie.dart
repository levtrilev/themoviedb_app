import 'package:json_annotation/json_annotation.dart';

import 'movie_date_parser.dart';
/*
// use "flutter pub run build_runner build" to generate file movie.g.dart
// or use "flutter pub run build_runner watch"to follow changes in your files
*/
part 'movie.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Movie {
  final String? posterPath;
  final bool adult;
  final String overview;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? releaseDate;
  // ignore: non_constant_identifier_names
  final List<int> genre_ids;
  final int id;
  final String originalTitle;
  final String originalLanguage;
  final String title;
  // ignore: non_constant_identifier_names
  final String? backdrop_path;
  final double popularity;
  final int voteCount;
  final bool video;
  final double voteAverage;

  Movie({
    required this.posterPath,
    required this.adult,
    required this.overview,
    required this.releaseDate,
    // ignore: non_constant_identifier_names
    required this.genre_ids,
    required this.id,
    required this.originalTitle,
    required this.originalLanguage,
    required this.title,
    // ignore: non_constant_identifier_names
    required this.backdrop_path,
    required this.popularity,
    required this.voteCount,
    required this.video,
    required this.voteAverage,
  });


  // static DateTime? _parseDateFromString(String? rawDate) {
  //   if (rawDate == null || rawDate.isEmpty) return null;
  //   return DateTime.tryParse(rawDate);
  // }

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
