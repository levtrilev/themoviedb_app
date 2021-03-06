import 'package:flutter/material.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';
//import 'package:themoviedb/widgets/example_state/example_state_widget.dart';
import 'package:themoviedb/widgets/main_screen/main_screen_model.dart';
import 'package:themoviedb/widgets/movie_list/movie_list_model.dart';
import 'package:themoviedb/widgets/movie_list/movie_list_widget.dart';
import 'package:themoviedb/widgets/paint_test/paint_test.dart';
import 'package:themoviedb/widgets/todo_list/todo_list_widget.dart';
import 'package:themoviedb/widgets/todo_list/todo_list_model.dart';

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
    // ignore: avoid_print
    print(model);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TMDB',
        ),
        actions: [
          IconButton(
            onPressed: () => SessionDataProvider().setSessionId(null),
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          NotifierProvider(
            create: () => movieListModel,
            child: const MovieListWidget(),
            isManagingModel: false,
          ),
          //Example(),
          const Center(child: PaintTestWidget()),
          NotifierProvider(
            create: () => todoListModel,
            child: const TodoListWidget(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: onSelectTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: '??????????????',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.movie_creation_outlined,
          //   ),
          //   label: '????????????',
          // ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.tv,
            ),
            label: '??????????????',
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
