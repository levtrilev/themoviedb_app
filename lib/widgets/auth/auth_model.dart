//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage = null;
  bool _isAuthProgress = false;

  String? get errorMessage => _errorMessage;
  bool get canStartAuth => !_isAuthProgress;

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;
    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Введите логин и пароль!';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    final sessionId = await _apiClient.auth(
      username: login,
      password: password,
    );
    _isAuthProgress = false;
    notifyListeners();
// Navigator.of(context).pushNamed(routeName);
  }
}

class AuthProvider extends InheritedNotifier {
  final AuthModel model;
  AuthProvider({
    Key? key,
    required this.model,
    required this.child,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );

  final Widget child;

  static AuthProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthProvider>();
  }

  static AuthProvider? read(BuildContext context) {
    final widget =
        context.getElementForInheritedWidgetOfExactType<AuthProvider>()?.widget;
    return widget is AuthProvider ? widget : null;
  }
}
