import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client.dart';
import 'package:themoviedb/domain/entity/todo_item.dart';

class TodoDetailsModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  late TodoItem _todoItem;
  TodoItem get todoItem => _todoItem;
  var _isLoadingInProgress = false;

  Future<void> loadTodoItem(int todoId) async {
    if (todoId == 0) {
      // todoId == 0 means to create a new todo
      final newTodo = TodoItem(
          id: 0,
          title: '',
          isCompleted: false,
          userId: 1,
          openDate: DateTime.now(),
          closeDate: DateTime.parse('2021-01-01'),
        );
        _todoItem = newTodo;
      return Future.delayed(const Duration(milliseconds: 20), () => newTodo);
    }
    if (_isLoadingInProgress) return;
    _isLoadingInProgress = true;

    try {
      final todo = await _apiClient.todoItemGet(todoId);
      if (todo == null) return;
      _todoItem = todo;
      _isLoadingInProgress = false;
      notifyListeners();
    } catch (e) {
      _isLoadingInProgress = false;
    }
  }

  Future<int> createTodoItem(TodoItem todoItemToCreate) async {
    try {
      final createdTodoId =
          await _apiClient.createTodoItem(todoItemToCreate: todoItemToCreate);
      return createdTodoId;
    } catch (e) {
      return 0;
    }
  }

  Future<int> updateTodoItem(TodoItem todoItemToUpdate) async {
    try {
      final updatedTodoId =
          await _apiClient.updateTodoItem(todoItemToUpdate: todoItemToUpdate);
      return updatedTodoId;
    } catch (e) {
      return 0;
    }
  }

  Future<bool> deleteTodoItem(int todoId) async {
    try {
      await _apiClient.todoItemDelete(todoId)?.then((deleted) {
        return deleted;
      });
    } catch (e) {
      return false;
    }
    return false;
  }
}
