import 'package:flutter/material.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';
//import 'package:themoviedb/widgets/example_state/example_state_widget.dart';
import 'package:themoviedb/widgets/main_screen/main_screen_model.dart';
import 'package:themoviedb/widgets/movie_list/movie_list_model.dart';
import 'package:themoviedb/widgets/movie_list/movie_list_widget.dart';
import 'package:themoviedb/widgets/paint_test/paint_test.dart';
import 'package:themoviedb/widgets/todo_list/todo1_list_widget.dart';
import 'package:themoviedb/widgets/todo_list/todo_list_model.dart';
import 'package:themoviedb/widgets/todo_list/todo_list_widget.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  _MainScreenWidgetState createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;
  final movieListModel = MovieListModel();
  final todoListModel = TodoListModel();

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    todoListModel.loadTodoItems();
    movieListModel.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MainScreenModel>(context);
    print(model);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TMDB',
        ),
        actions: [
          IconButton(
            onPressed: () => SessionDataProvider().setSessionId(null),
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          NotifierProvider(
              model: movieListModel, child: const MovieListWidget()),
          //Example(),
          Center(child: PaintTestWidget()),
          NotifierProvider(
              model: todoListModel, child: const Todo1ListWidget()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: onSelectTab,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Новости',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.movie_creation_outlined,
          //   ),
          //   label: 'Фильмы',
          // ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.tv,
            ),
            label: 'Сериалы',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.today,
            ),
            label: 'todo',
          ),
        ],
      ),
    );
  }
}
