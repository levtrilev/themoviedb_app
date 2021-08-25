import 'dart:convert';
import 'dart:io'; // for mobile (non-web)

class ApiClient {
  final _client = HttpClient();
  static const _host = 'http://api.themoviedb.org/3';
  //static const _imageUrl = 'http://tmdb.org/t/p/w500';
  static const _apiKey = '0a2a46b5593a0978cc8e87ba34037430';

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

  Future<String> _makeToken() async {
    final url = Uri.parse('$_host/authentication/token/new?api_key=$_apiKey');
    final request = await _client.getUrl(url);
    final responce = await request.close();
    final json = await responce
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);
    final token = json['request_token'] as String;
    return token;
  }

  Future<String> _validateUser({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final url = Uri.parse(
        '$_host/authentication/token/validate_with_login?api_key=$_apiKey');
    final parameters = <String, dynamic>{
      'username': username,
      'password': password,
      'request_token': requestToken
    };
    final request = await _client.postUrl(url);
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parameters));
    final responce = await request.close();
    final json = await responce
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);
    final token = json['request_token'] as String;
    return token;
  }

  Future<String> _makeSession({
    required String requestToken,
  }) async {
    final url = Uri.parse('$_host/authentication/session/new?api_key=$_apiKey');
    final parameters = <String, dynamic>{'request_token': requestToken};
    final request = await _client.postUrl(url);
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parameters));
    final responce = await request.close();
    final json = await responce
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);
    final sessionId = json['session_id'] as String;
    return sessionId;
  }
}
