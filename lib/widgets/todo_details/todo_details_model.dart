import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client.dart';
import 'package:themoviedb/domain/entity/todo_item.dart';

class TodoDetailsModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  late TodoItem _todoItem;
  TodoItem get todoItem => _todoItem;
  var _isLoadingInProgress = false;

  Future<void> loadTodoItem(int todoId) async {
    if (_isLoadingInProgress) return;
    _isLoadingInProgress = true;

    try {
      final todo = await _apiClient.todoItemGet(todoId);
      print (todo);
      if (todo == null) return;
      _todoItem = todo;
      _isLoadingInProgress = false;
      notifyListeners();
    } catch (e) {
      _isLoadingInProgress = false;
    }
  }

}
