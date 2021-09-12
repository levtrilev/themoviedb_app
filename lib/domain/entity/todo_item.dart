import 'package:json_annotation/json_annotation.dart';
/*
// use "flutter pub run build_runner build" to generate file movie.g.dart
// or use "flutter pub run build_runner watch"to follow changes in your files
*/
part 'todo_item.g.dart';

@JsonSerializable()
class TodoItem {
  final int id;
  final String title;
  final bool isCompleted;
  final int userId;
  final DateTime openDate;
  final DateTime closeDate;

  TodoItem({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.userId,
    required this.openDate, 
    required this.closeDate, 
  });

  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);

  Map<String, dynamic> toJson() => _$TodoItemToJson(this);
}
