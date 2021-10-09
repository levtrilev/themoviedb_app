//import 'dart:ffi';
//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();
  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;
  bool _isAuthProgress = false;

  String? get errorMessage => _errorMessage;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

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
    String? sessionId;
    int? accountId;
    try {
      sessionId = await _apiClient.auth(
        username: login,
        password: password,
      );
      accountId = await _apiClient.getAccountInfo(sessionId);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          _errorMessage = 'Сервер недоступен! Проверьте соединение.';
          break;
        case ApiClientExceptionType.auth:
          _errorMessage = 'Неправильный логин пароль!';
          break;
        case ApiClientExceptionType.other:
          _errorMessage =
              'Произошла ошибка (ApiClientExceptionType.Other) ошибка: ${e.toString()}- попробуйде еще раз!';
          break;
        case ApiClientExceptionType.apiKey:
          _errorMessage =
              'Произошла ошибка - неверный ApiKey!';
          break;
        case ApiClientExceptionType.token:
          _errorMessage =
              'Произошла ошибка - неверный request token!';
          break;
      }
    } //catch (e) {
    //   _errorMessage =
    //           'Произошла ошибка: ${e.toString()}- попробуйде еще раз!';
    // }
    _isAuthProgress = false;
    if (_errorMessage != null) {
      notifyListeners();
      return;
    }
    if (sessionId == null || accountId == null) {
      _errorMessage = 'Неизвестная ошибка (нет sesionId|accountId), повторите попытку.';
      notifyListeners();
      return;
    }
    await _sessionDataProvider.setSessionId(sessionId);
    await _sessionDataProvider.setAccountId(accountId);
    Navigator.of(context)
        .pushReplacementNamed(MainNavigationRouteNames.mainScreen);
  }
}
