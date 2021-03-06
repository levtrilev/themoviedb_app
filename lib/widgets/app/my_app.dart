import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:themoviedb/ui/Theme/app_colors.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';
import 'package:themoviedb/widgets/app/my_app_model.dart';

class MyApp extends StatelessWidget {
  final MyAppModel model;
  static final mainNavigation = MainNavigation();
  const MyApp({
    Key? key,
    required this.model,
  }) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'themoviedb.org client',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', 'RU'), // Russian, country code
        Locale('en', 'EN'), // English, no country code
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.mainDarkBlue,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.mainDarkBlue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
      ),
      initialRoute: mainNavigation.initialRoute(model.isAuth),
      routes: mainNavigation.routs,
      onGenerateRoute: (RouteSettings settings) => mainNavigation.onGenerateRoute(settings),
      // {
      //   return MaterialPageRoute<void>(builder: (context) {
      //     return const Scaffold(
      //       body: Center(child: Text('Произошла ошибка навигации')),
      //     );
      //   });
      // },
    );
  }
}
