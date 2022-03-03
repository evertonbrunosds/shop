import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/auth_exception.dart';

class Auth with ChangeNotifier {
  String get _key => 'AIzaSyCZRuGItyD4yPjTF9Pz8XM2UMFxXk_QjHw';
  String? _token;
  String? _email;
  String? _uid;
  DateTime? _expiryDate;

  bool get isAuth {
    final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token => isAuth ? _token : null;

  String? get email => isAuth ? _email : null;

  String? get uid => isAuth ? _uid : null;

  Future<void> _authentication(
    String email,
    String password,
    String urlFragment,
  ) async {
    final response = await http.post(
      Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=$_key'),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    final body = jsonDecode(response.body);
    if (body['error'] != null) {
      throw AuthException(key: body['error']['message']);
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _uid = body['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(body['expiresIn']),
        ),
      );
      notifyListeners();
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
