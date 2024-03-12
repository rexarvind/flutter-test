import 'dart:convert';

import 'package:get/get.dart' as GET;
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = 'https://client90.000webhostapp.com/api';
  static const baseUrl2 = 'https://shop.rexwebmedia.com/api';

  static final dio = Dio(
    BaseOptions(baseUrl: '', receiveDataWhenStatusError: true),
  );

  static void initializeInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) async {
          var token = await GetStorage().read('auth_token');
          var headers = {
            'Accept': 'application/json',
            'Content-Type': 'text/plain',
            'Authorization': 'Bearer $token',
          };
          request.headers.addAll(headers);
          // print('${request.method} ${request.path}');
          return handler.next(request);
        },
        onResponse: (response, handler) {
          // print('RES ${response.data}');
          if (response.data['success'] == false) {
            if (GET.Get.isDialogOpen == true) {
              GET.Get.back();
            }
            GET.Get.snackbar(
              'Error'.tr,
              response.data['message'] ?? 'An error occurred',
              snackPosition: GET.SnackPosition.TOP,
            );
            // throw response.data;
          }
          return handler.next(response);
        },
        onError: (error, handler) {
          if (GET.Get.isDialogOpen == true) {
            GET.Get.back();
          }
          print(error.response?.data['message']);
          print('HERE::::::::::: $error');
          GET.Get.snackbar(
            'Error'.tr,
            error.response?.data['message'] ?? 'An error occrred, try later',
            snackPosition: GET.SnackPosition.TOP,
          );
          return handler.next(error);
        },
      ),
    );
  }

  static Future<Response> login({
    required Map<String, dynamic> loginData,
  }) async {
    return dio.post(
      '$baseUrl/v1/login/',
      data: jsonEncode(loginData),
    );
  }

  static Future<Response> register({
    required Map<String, dynamic> registerData,
  }) async {
    return dio.post(
      '$baseUrl/v1/register/',
      data: jsonEncode(registerData),
    );
  }

  static Future<Response> getUser({required String token}) async {
    return await dio.post('$baseUrl/v1/user/',
        data: jsonEncode({'token': token}));
  }

  static Future getUserSilently({required String token}) async {
    final response = await http.post(Uri.parse('$baseUrl/v1/user/'),
        body: jsonEncode({'token': token}));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {};
    }
  }

  static saveFCMToken({
    required String userId,
    required String token,
  }) {
    http.post(
      Uri.parse('$baseUrl/v1/notifications/firebase/'),
      body: jsonEncode({'userId': userId, 'token': token}),
    );
  }

  static saveAndroidFCMToken({
    required String userId,
    required String token,
  }) {
    http.post(
      Uri.parse('$baseUrl/v1/notifications/firebase/'),
      body: jsonEncode(
          {'userId': userId, 'token': token, 'deviceName': 'android'}),
    );
  }

  static Future<Response> getNotes() async {
    return dio.get('$baseUrl/v1/notes/', queryParameters: {
    });
  }
}
