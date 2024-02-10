import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:platform_device_id_v3/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/user.dart';
import '../models/api_response.dart';

// login

Future<ApiResponse> login(String username, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String deviceId = await getDeviceId();
    final response = await http.post(
      Uri.parse(kApiLoginUrl),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: json.encode(
          {'username': username, 'password': password, 'deviceId': deviceId}),
    );
    switch (response.statusCode) {
      case 200:
        var jsonResponse = jsonDecode(response.body);
        apiResponse.data = User.fromJson(jsonResponse);
        apiResponse.statusCode = 200;
        if(jsonResponse.containsKey('token')){
          SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.setString('token', jsonResponse['token']);
          await pref.setInt('userId', int.tryParse(jsonResponse['user']['id']) ?? 0);
        }
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        apiResponse.statusCode = 422;
        break;
      case 401:
        apiResponse.error = jsonDecode(response.body)['message'];
        apiResponse.statusCode = 401;
      default:
        apiResponse.error = 'Something went wrong';
        apiResponse.statusCode = 500;
        break;
    }
  } catch (e) {
    apiResponse.error = 'Connection failed';
  }
  return apiResponse;
}

// get user

Future<ApiResponse> getUserDetail() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(kApiUserUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });
    switch (response.statusCode) {
      case 200:
        var jsonResponse = jsonDecode(response.body);
        apiResponse.data = User.fromJson(jsonResponse);
        apiResponse.statusCode = 200;
        break;
      case 401:
        apiResponse.error = 'Unauthorised';
        apiResponse.statusCode = 401;
        break;
      default:
        apiResponse.error = 'Something went wrong';
        apiResponse.statusCode = 500;
        break;
    }
  } catch (e) {
    apiResponse.error = 'Connetion error.';
    apiResponse.statusCode = 500;
  }
  return apiResponse;
}

Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}

Future<int> getTokenId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('userId') ?? 0;
}

Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return await pref.remove('token');
}

Future<String> getDeviceId() async {
  String? deviceId = await PlatformDeviceId.getDeviceId;
  return deviceId ?? 'app';
}
