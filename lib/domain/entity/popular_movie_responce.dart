import 'package:json_annotation/json_annotation.dart';
import 'package:themoviedb/domain/entity/movie.dart';
/*
// use "flutter pub run build_runner build" to generate file movie.g.dart
// or use "flutter pub run build_runner watch"to follow changes in your files
//
// flutter pub run build_runner build --delete-conflicting-outputs
*/
part 'popular_movie_responce.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PopularMovieResponce {
  final int page;
  @JsonKey(name: 'results')
  final List<Movie> movies;
  final int totalResults;
  final int totalPages;

  PopularMovieResponce({
    required this.page,
    required this.movies,
    required this.totalResults,
    required this.totalPages,
  });

  factory PopularMovieResponce.fromJson(Map<String, dynamic> json) =>
      _$PopularMovieResponceFromJson(json);

  Map<String, dynamic> toJson() => _$PopularMovieResponceToJson(this);
}
