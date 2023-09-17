import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/user.dart';



/*
class AuthNotifier extends StateNotifier {
  AuthNotifier() : super([]);

  bool authenticated = false;
  User? user;
  final storage = const FlutterSecureStorage();

  Future register({credential}) async {
    String deviceId = await getDeviceId();
    try {
      final res = await http.post(
        Uri.https(kApiBase, 'register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'deviceId': await getDeviceId(),
          },
        ),
      );
    } catch (e) {
      log('error log ${e.toString()}');
    }
  }

  Future attempt(String? token) async {
    try {
      final res = await http.post(
        Uri.https(kApiBase, 'user'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      user = User.fromJson(res.body as Map<String, dynamic>);
      authenticated = true;
    } catch (e) {
      log('error log ${e.toString()}');
      authenticated = false;
    }
  }

  Future getDeviceId() async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    return deviceId;
  }

  Future storeToken(String token) async {
    await storage.write(key: 'auth', value: 'token');
  }

  Future getToken() async {
    final token = await storage.read(key: 'auth');
    return token;
  }

  Future deleteToken() async {
    await storage.delete(key: 'auth');
  }

  Future logout() async {
    final token = await storage.read(key: 'auth');
    authenticated = false;
    await http.post(
      Uri.https(kApiBase, 'logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(
        {
          'deviceId': await getDeviceId(),
        },
      ),
    );
    await deleteToken();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, dynamic>((ref) {
  return AuthNotifier();
});
*/