import 'package:flutter/material.dart';
import 'package:get/get.dart' as GET;
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;


class Api {
  static final dio = Dio(
    BaseOptions(
      baseUrl: 'https://client90.000webhostapp.com',
      // baseUrl: 'https://jsonplaceholder.typicode.com',
      receiveDataWhenStatusError: true,
    ),
  );

  static void initializeInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) async {
          var token = await GetStorage().read('login_token');
          var headers = {
            'Accept': 'application/json',
            'Content-Type': 'text/plain',
            'Authorization': 'Bearer $token',
          };
          request.headers.addAll(headers);
          print('${request.method} ${request.path}');
          return handler.next(request);
        },
        onResponse: (response, handler) {
          print('${response.data}');
          if (response.data['error'] == 1) {
            throw response.data['message'];
          }
          return handler.next(response);
        },
        onError: (error, handler) {
          if (GET.Get.isDialogOpen == true) {
            GET.Get.back();
          }
          GET.Get.snackbar(
            'Error'.tr,
            '${error.message}',
            snackPosition: GET.SnackPosition.TOP,
          );
          print('ERROR RES: $error');
          return handler.next(error);
        },
      ),
    );
  }

  static Future<Response> getNotes() async {
    return dio.get('/testing.php');
  }


}
