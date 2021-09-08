import 'dart:async';

import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client.dart';
import 'package:themoviedb/domain/entity/todo_item.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class TodoListModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _todoItems = <TodoItem>[];
  List<TodoItem> get todoItems => List.unmodifiable(_todoItems);
  var _isLoadingInProgress = false;
  Timer? searchDebounce;
  String? _searchQuery;

  Future<void> _loadTodoItems() async {
    if (_isLoadingInProgress) return;
    _isLoadingInProgress = true;

    try {
      final todos = await _apiClient.todoItemsGet();
      print(todos);
      if (todos == null) return;
      _todoItems.clear();
      _todoItems.addAll(todos);
      _isLoadingInProgress = false;
      notifyListeners();
    } catch (e) {
      _isLoadingInProgress = false;
    }
  }

  Future<void> searchTodoItems(String query) async {
    searchDebounce?.cancel();
    searchDebounce = Timer(const Duration(seconds: 1), () async {
      final searchQuery = query.isNotEmpty ? query : null;
      if (searchQuery == null) return;
      if (_searchQuery == searchQuery) return;
      _searchQuery = searchQuery;

      if (_isLoadingInProgress) return;
      _isLoadingInProgress = true;

      try {} catch (e) {
        _isLoadingInProgress = false;
      }
    });
  }

  void onTodoItemTap(BuildContext context, int index) async {
    // index = -1 means to create new todo => call todoDetails(id = 0)
    final id = index > 0 ? _todoItems[index].id : 0;
    print(id.toString());
    final createdTodoItemId = await Navigator.of(context)
        .pushNamed(MainNavigationRouteNames.todoDetails, arguments: id);
    if (createdTodoItemId != null &&
        (createdTodoItemId as int > 0 || createdTodoItemId == -1))
      _loadTodoItems();
  }

  void loadTodoItems() {
    _loadTodoItems();
  }

  void showedTodoAtIndex(int index) {
    // if (index < _todoItems.length - 1) return;
    // _loadTodoItems();
  }
}
