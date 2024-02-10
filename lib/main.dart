import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import './services/api.dart';
import './screens/splash_screen.dart';

void main() async {
  await GetStorage.init();
  Api.initializeInterceptors();
  runApp(const MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.dark,
      locale: const Locale('en'),
      fallbackLocale: const Locale('en'),
      scrollBehavior: MyCustomScrollBehavior(),
      home: SplashScreen(),
    );
  }
}

// void main() {
//   runApp(
//     GetMaterialApp(
//         debugShowCheckedModeBanner: false,
//         initialRoute: Routes.SPLASH,
//         theme: appThemeData,
//         defaultTransition: Transition.fade,
//         initialBinding: SplashBinding(),
//         getPages: AppPages.pages,
//         home: SplashPage(),
//     )
//   );
// }