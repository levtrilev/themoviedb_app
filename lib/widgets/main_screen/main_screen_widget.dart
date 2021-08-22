import 'package:flutter/material.dart';
import 'package:themoviedb/widgets/example_state/example_state_widget.dart';
import 'package:themoviedb/widgets/movie_list/movie_list_widget.dart';
import 'package:themoviedb/widgets/paint_test/paint_test.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  _MainScreenWidgetState createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TMDB',
        ),
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          Example(),
          Center(child: PaintTestWidget()),
          MovieListWidget(),
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
          BottomNavigationBarItem(
            icon: Icon(
              Icons.movie_creation_outlined,
            ),
            label: 'Фильмы',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.tv,
            ),
            label: 'Сериалы',
          ),
        ],
      ),
    );
  }
}
