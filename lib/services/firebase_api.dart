import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/auth_controller.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  bool isFlutterLocalNotificationsInitialized = false;
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }

  Future<void> initNotifications() async {
    try {
      final authController = Get.find<AuthController>();
      await _firebaseMessaging.requestPermission();
      if (kIsWeb) {
        final fCMToken = await _firebaseMessaging.getToken(
          vapidKey:
              'BMcP2WWC5k5pY8Nqx0_-rwFK27uwU9PmLPa7KQqn5OHWxpf9rPTq0X6iVDiH4AScoy5p8DY0FgFkjGgNB6OMpOE',
        );
        Get.snackbar('TOKEN', fCMToken.toString());
      } else {
        final fCMToken = await _firebaseMessaging.getToken();
        if (fCMToken != null) {
          await GetStorage().write('fcm_android_token', fCMToken);
          authController.saveAndroidFCMToken(token: fCMToken);
        }
        Get.snackbar('TOKEN', fCMToken.toString());
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: 'launch_background',
          ),
        ),
      );
    }
  }
}
