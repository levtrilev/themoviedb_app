import 'dart:async';

import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client.dart';
import 'package:themoviedb/domain/entity/todo_item.dart';

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
      print (todos);
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

      //final nextPage = 1;
      try {
        // To implement:
        // final moviesResponce =
        //     await _apiClient.searchMovie(nextPage, 'ru-RU', searchQuery);
        // _movies.clear();
        // _movies.addAll(moviesResponce.movies);
        // _isLoadingInProgress = false;
        // _currentPage = moviesResponce.page;
        // _totalPages = moviesResponce.totalPages;
        // notifyListeners();
      } catch (e) {
        _isLoadingInProgress = false;
      }
    });
  }

  void onTodoItemTap(BuildContext context, int index) {
    final id = _todoItems[index].id;
    print(id.toString());
    // To implement route: todoItemDetails
    // Navigator.of(context)
    //     .pushNamed(MainNavigationRouteNames.todoItemDetails, arguments: id);
  }

  void loadTodoItems () {
    _loadTodoItems();
  }

  void showedTodoAtIndex(int index) {
    // if (index < _todoItems.length - 1) return;
    // _loadTodoItems();
  }
}
