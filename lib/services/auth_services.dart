import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

final authProvider = Provider<AuthServices>((ref) {
  return AuthServices();
});

class AuthServices {
  Future<bool> login({
    required String username,
    required String password,
  }) async {
    bool isLoggedIn = false;
    final res = await http.post(
      Uri.https(kApiBase, 'login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'username': username,
          'password': password,
          'deviceId': 'web',
        },
      ),
    );
    if (res.statusCode >= 200) {
      isLoggedIn = true;
    }
    return isLoggedIn;
  }
}
