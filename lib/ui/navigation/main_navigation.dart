// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';
import 'package:themoviedb/widgets/auth/auth_model.dart';
import 'package:themoviedb/widgets/auth/auth_widget.dart';
import 'package:themoviedb/widgets/auth/json_test.dart';
import 'package:themoviedb/widgets/auth/reset_password.dart';
import 'package:themoviedb/widgets/example_inherited/inherited_notifier_example.dart';
import 'package:themoviedb/widgets/example_inherited/pass_data_to_child.dart';
import 'package:themoviedb/widgets/main_screen/main_screen_model.dart';
import 'package:themoviedb/widgets/main_screen/main_screen_widget.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_widget.dart';
import 'package:themoviedb/widgets/movie_trailer/movie_trailer_widget.dart';
import 'package:themoviedb/widgets/todo_details/todo_details_widget.dart';

abstract class MainNavigationRouteNames {
  static const auth = 'auth';
  static const mainScreen = '/';
  static const movieDetails = '/movie_details';
  static const movieTrailerWidget = '/movie_details/trailer';
  static const resetPassword = '/reset_password';
  static const jsonTest = '/json_test';
  static const passDataToChild = '/pass_data_to_child';
  static const inheritedNotifierExample = '/inherited_notifier_example';
  static const todoDetails = '/todo_details';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteNames.mainScreen
      : MainNavigationRouteNames.auth;
  final routs = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.auth: (context) => NotifierProvider(
          child: const AuthWidget(),
          create: () => AuthModel(),
        ),
    MainNavigationRouteNames.mainScreen: (context) => NotifierProvider(
          create: () => MainScreenModel(),
          child: const MainScreenWidget(),
        ),
    MainNavigationRouteNames.movieDetails: (context) {
      int movieId;
      final arguments = ModalRoute.of(context)!.settings.arguments;
      if (arguments is int) {
        movieId = arguments;
      } else {
        movieId = 0;
      }
      return NotifierProvider(
        child: const MovieDetailsWidget(),
        create: () => MovieDetailsModel(movieId: movieId)..setupLocale(context),
      );
    },
    MainNavigationRouteNames.todoDetails: (context) {
      final arguments = ModalRoute.of(context)!.settings.arguments;
      final todoId = arguments is int ? arguments : 0;
      return TodoDetailsWidget(todoId: todoId);
    },
    MainNavigationRouteNames.resetPassword: (context) =>
        const ResetPasswordWidget(),
    MainNavigationRouteNames.jsonTest: (context) => const JsonTestWidget(),
    MainNavigationRouteNames.passDataToChild: (context) =>
        const PassDataToChild(),
    MainNavigationRouteNames.inheritedNotifierExample: (context) =>
        const InheritedNotifierExample(),
  };
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (context) => NotifierProvider(
            child: const MovieDetailsWidget(),
            create: () => MovieDetailsModel(movieId: movieId),
          ),
        );
      case MainNavigationRouteNames.movieTrailerWidget:
              final arguments = settings.arguments;
              final youtubeKey = arguments is String ? arguments : '';
                      return MaterialPageRoute(
          builder: (context) => MovieTrailerWidget(youtubeKey: youtubeKey,),
        );
      default:
      const widget = Text('Navigation Error!!!...');
      return MaterialPageRoute(builder: (context) => widget); 
    }
  }
}
