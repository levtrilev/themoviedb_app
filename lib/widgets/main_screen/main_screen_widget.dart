import 'package:flutter/material.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  _MainScreenWidgetState createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;
  List<Widget> tabWidgets = [
    Text('Новости'),
    Text('Фильмы'),
    Text('Сериалы'),
  ];

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
      body: Center(
        child: tabWidgets[_selectedTab],
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
