import 'package:flutter/material.dart';
import 'package:themoviedb/widgets/auth/auth_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'themoviedb.org client',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromRGBO(3, 37, 65, 1),
        ),
      ),
      home: AuthWidget(),
      // home: Text('start from here'),
    );
  }
}