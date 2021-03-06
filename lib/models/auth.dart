import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/auth_exception.dart';

class Auth with ChangeNotifier {
  String get _key => 'AIzaSyCZRuGItyD4yPjTF9Pz8XM2UMFxXk_QjHw';
  String? _token;
  String? _email;
  String? _userId;
  DateTime? _expiryDate;
  Timer? _signOutTimer;

  bool get isAuth {
    final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token => isAuth ? _token : null;

  String? get email => isAuth ? _email : null;

  String? get userId => isAuth ? _userId : null;

  void signOut() {
    _token = null;
    _email = null;
    _userId = null;
    _expiryDate = null;
    _clearAutoSignOutTimer();
    notifyListeners();
  }

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
      _userId = body['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(body['expiresIn']),
        ),
      );
      _autoSignOut();
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

  void _clearAutoSignOutTimer() {
    _signOutTimer?.cancel();
    _signOutTimer = null;
  }

  void _autoSignOut() {
    _clearAutoSignOutTimer();
    final timeToSignOut = _expiryDate?.difference(DateTime.now()).inSeconds;
    _signOutTimer = Timer(Duration(seconds: timeToSignOut ?? 0), signOut);
  }
}
