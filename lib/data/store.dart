import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Store {
  static Future<bool> saveString(
    final String key,
    final String value,
  ) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(key, value);
  }

  static Future<bool> saveMap(
    final String key,
    final Map<String, dynamic> value,
  ) async {
    return saveString(key, jsonEncode(value));
  }
}
