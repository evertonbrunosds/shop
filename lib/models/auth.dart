import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/auth_exception.dart';

class Auth with ChangeNotifier {
  String get _token => 'AIzaSyCZRuGItyD4yPjTF9Pz8XM2UMFxXk_QjHw';

  Future<void> _authentication(
    String email,
    String password,
    String urlFragment,
  ) async {
    final response = await http.post(
      Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=$_token'),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    final body = jsonDecode(response.body);
    if (body['error'] != null) {
      throw AuthException(key: body['error']['message']);
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async =>
      _authentication(email, password, 'signUp');

  Future<void> signIn({
    required String email,
    required String password,
  }) async =>
      _authentication(email, password, 'signInWithPassword');
}
