import 'dart:convert';
import 'dart:io';

import 'package:themoviedb/domain/entity/todo_item.dart';

import 'entity/popular_movie_responce.dart'; // for mobile (non-web)

/*
// Возможные ошибки при соединении:
//
// 1. Нет сети
// 2. Нет ответа - таймаут соединения
// 3. Сервер недоступен
// 4. Сервер не может обработать запрос
// 5. Сервер ответил не то, что мы ожидали
// 6. Сервер ответил ожидаемой ошибкой
*/

enum ApiClientExceptionType { Network, Auth, ApiKey, Other, Token }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;
  // final String errorMessage;

  ApiClientException(this.type);
}

class ApiClient {
  final _client = HttpClient();
  static const _host = 'http://api.themoviedb.org/3';
  static const _hostMin = 'http://10.0.2.2:5000';
  static const _imageUrl = 'http://tmdb.org/t/p/w500';
  static const _apiKey = '0a2a46b5593a0978cc8e87ba34037430';

  static imageUrl(String path) {
    return _imageUrl + path;
  }

  Future<List<TodoItem>?> minimalApiGet() async {
    final parser = (dynamic json) {
      final jsonMapList = json.map((e) => e as Map<String, dynamic>);
      final responce = jsonMapList.map((e) => TodoItem.fromJson(e)).toList();
      return responce;
    };
    final result = await _get(_hostMin, '/todoitems', parser);
    return result;
    // // _client.connectionTimeout = Duration.zero;
    // final url = Uri.parse('$_host/authentication/token/new?api_key=$_apiKey');
    // //final urlMin = Uri.parse('http://10.0.2.2:5000/todoitems');
  }

  Future<List<TodoItem>>? todoItemsGet() async {
    final parser = (dynamic json) {
      final responce = (json as List<dynamic>)
          .map((e) => TodoItem.fromJson(e as Map<String, dynamic>))
          .toList();
      return responce;
    };

    final result = _get(_hostMin, '/todoitems', parser);

    return result;
  }

    Future<TodoItem>? todoItemGet(int id) async {
    final parser = (dynamic json) {
      final responce = TodoItem.fromJson(json as Map<String, dynamic>);
      return responce;
    };

    final result = _get(_hostMin, '/todoitems/${id.toString()}', parser);
    return result;
  }

  Future<String> auth({
    required String username,
    required String password,
  }) async {
    final token = await _makeToken();
    final validToken = await _validateUser(
      username: username,
      password: password,
      requestToken: token,
    );
    final sessionId = await _makeSession(requestToken: validToken);
    return sessionId;
  }

  Future<T> _get<T>(
    String host,
    String path,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? parameters,
  ]) async {
    final url = _makeUri(host, path, parameters);
    try {
      final request = await _client.getUrl(url);
      final responce = await request.close();
      final dynamic json = (await responce.jsonDecode());
      _validateResponce(responce, json);
      final result = parser(json);
      return result;
      // final token = json['request_token'] as String;
      // return token;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (e) {
      print(e.toString());
      //rethrow;
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }

  Future<T> _post<T>(
    String host,
    String path,
    Map<String, dynamic>? bodyParameters,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? urlParameters,
  ]) async {
    try {
      // final parameters = <String, dynamic>{
      //   'username': username,
      //   'password': password,
      //   'request_token': requestToken
      // };
      final url = _makeUri(host, path, urlParameters);
      // final url = Uri.parse(
      //     '$_host/authentication/token/validate_with_login?api_key=$_apiKey');

      final request = await _client.postUrl(url);
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(bodyParameters));
      final responce = await request.close();
      final dynamic json = (await responce.jsonDecode());

      _validateResponce(responce, json);
      final result = parser(json);
      return result;
      // final token = json['request_token'] as String;
      // return token;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      //rethrow;
      throw ApiClientException(ApiClientExceptionType.Other);
    }
  }

  Future<String> _makeToken() async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    };

    final result = _get(_host, '/authentication/token/new', parser,
        <String, dynamic>{'api_key': _apiKey});
    return result;
    // // _client.connectionTimeout = Duration.zero;
    // final url = Uri.parse('$_host/authentication/token/new?api_key=$_apiKey');
    // //final urlMin = Uri.parse('http://10.0.2.2:5000/todoitems');
  }

  Future<PopularMovieResponce> popularMovie(int page, String locale) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final responce = PopularMovieResponce.fromJson(jsonMap);
      return responce;
    };

    final result = _get(_host, '/movie/popular', parser, <String, dynamic>{
      'api_key': _apiKey,
      'page': page.toString(),
      'language': locale,
    });
    return result;
  }

  Future<PopularMovieResponce> searchMovie(
    int page,
    String locale,
    String query,
  ) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final responce = PopularMovieResponce.fromJson(jsonMap);
      return responce;
    };

    final result = _get(_host, '/search/movie', parser, <String, dynamic>{
      'api_key': _apiKey,
      'page': page.toString(),
      'language': locale,
      'query': query,
      'include_adult': true.toString(),
    });
    return result;
  }

  Future<int> createTodoItem({
    required TodoItem todoItemToCreate,
  }) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final createdId = jsonMap['id'] as int;
      return createdId;
    };
    final bodyParameters = <String, dynamic>{
      'id': 0,
      'title': todoItemToCreate.title,
      'isCompleted': todoItemToCreate.isCompleted
    };
    final result = _post(
      _hostMin,
      '/todoitems',
      bodyParameters,
      parser,
    );
    return result;
  }

  Future<String> _validateUser({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    };
    final bodyParameters = <String, dynamic>{
      'username': username,
      'password': password,
      'request_token': requestToken
    };
    final result = _post(
      _host,
      '/authentication/token/validate_with_login',
      bodyParameters,
      parser,
      <String, dynamic>{'api_key': _apiKey},
    );
    return result;
  }

  Future<String> _makeSession({
    required String requestToken,
  }) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final sessionId = jsonMap['session_id'] as String;
      return sessionId;
    };
    final bodyParameters = <String, dynamic>{'request_token': requestToken};
    final result = _post(
      _host,
      '/authentication/session/new',
      bodyParameters,
      parser,
      <String, dynamic>{'api_key': _apiKey},
    );
    return result;
  }

  Uri _makeUri(String host, String path, [Map<String, dynamic>? parameters]) {
    // _client.connectionTimeout = Duration.zero;
    final uri = Uri.parse('$host$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
    //final url = Uri.parse('$_host/authentication/token/new?api_key=$_apiKey');
    //final urlMin = Uri.parse('http://10.0.2.2:5000/todoitems');
  }

  void _validateResponce(HttpClientResponse responce, dynamic json) {
    if (responce.statusCode == 401) {
      final dynamic status = json['status_code'];
      final code = status is int ? status : 0;
      if (code == 30) {
        // 30 - неверный логин-пароль 7 - невнрный ApiKey 33 - неверный токен
        throw ApiClientException(ApiClientExceptionType.Auth);
      } else if (code == 7) {
        throw ApiClientException(ApiClientExceptionType.ApiKey);
      } else if (code == 33) {
        throw ApiClientException(ApiClientExceptionType.Token);
      } else {
        throw ApiClientException(ApiClientExceptionType.Other);
      }
    }
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder).toList().then((value) {
      final stringJson = value.join();
      return stringJson;
    }).then<dynamic>((v) => json.decode(v));
  }
}
