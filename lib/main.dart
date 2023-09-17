import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './pages/home_page.dart';
import './pages/settings_page.dart';
// import './auth_service.dart';

// AuthService authService = AuthService();

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeMode getSavedTheme() {
    // Load the saved theme from SharedPreferences.
    // If it doesn't exist or is not set, return the default theme.
    // You can customize your default theme here.
    return ThemeMode.dark;
  }
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: getSavedTheme(),
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const HomePage(),
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context){
          switch (routeSettings.name){
            case SettingsPage.routeName:
              return const SettingsPage();
            default:
              return const HomePage();
          }
        });
      },
    );
  }
}
