import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import './pages/home_page.dart';
import './pages/settings_page.dart';
// import './auth_service.dart';

// AuthService authService = AuthService();
const kThemeKey = 'theme_key';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String theme = prefs.getString(kThemeKey) ?? 'system';

  runApp(
    ProviderScope(
      child: MainApp(theme: theme,),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.theme});
  final String theme;

  @override
  Widget build(BuildContext context) {
    ThemeMode getSavedTheme() {
      if(theme == 'dark'){
        return ThemeMode.dark;
      } else if(theme == 'light'){
        return ThemeMode.light;
      } else {
        return ThemeMode.system;
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: getSavedTheme(),
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const HomePage(),
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) {
              switch (routeSettings.name) {
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
