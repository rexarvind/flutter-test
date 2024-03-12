// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../constants.dart';

// class SettingsService {
//   /// Loads the User's preferred ThemeMode from local storage.
//   Future<ThemeMode> themeMode() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String savedTheme = prefs.getString(kThemeKey) ?? 'system';
//     if (savedTheme == 'dark') {
//       return ThemeMode.dark;
//     } else if (savedTheme == 'light') {
//       return ThemeMode.light;
//     } else {
//       return ThemeMode.system;
//     }
//   }

//   Future<String> theme()async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String savedTheme = prefs.getString(kThemeKey) ?? 'system';
//     return savedTheme;
//   }

//   /// Persists the user's preferred ThemeMode to local storage.
//   // Use the shared_preferences package to persist settings locally or the
//   Future<void> updateTheme(String theme) async {
//     if(theme == 'dark' || theme == 'light' || theme == 'system'){
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString(kThemeKey, theme);
//     }
//   }
// }
