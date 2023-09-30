import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier({ref}) : super(ThemeMode.system) {
    SharedPreferences.getInstance().then((prefs) {
      String savedTheme = prefs.getString(kThemeKey) ?? 'system';
      if (savedTheme == 'light') {
        state = ThemeMode.light;
      } else if (savedTheme == 'dark') {
        state = ThemeMode.dark;
      } else {
        state = ThemeMode.system;
      }
    });
  }

  String changeTheme(String theme) {
    if (theme == 'dark' || theme == 'light' || theme == 'system') {
      SharedPreferences.getInstance().then((prefs){
        prefs.setString(kThemeKey, theme);
      });
      if (theme case 'light') {
        state = ThemeMode.light;
      } else if (theme case 'dark') {
        state = ThemeMode.dark;
      } else {
        state = ThemeMode.system;
      }
    }
    return theme;
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier(ref: ref);
});
