import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeToggle extends StatefulWidget {
  const ThemeToggle({super.key});

  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  String _selectedTheme = 'system';
  final String _themeKey = 'theme_key';

  _loadSelectedTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedTheme = prefs.getString(_themeKey) ?? 'system';
    setState(() {
      _selectedTheme = savedTheme;
    });
  }

  _changeTheme(String theme) {
    setState(() {
      _selectedTheme = theme;
    });
    _saveSelectedTheme(theme);
  }

  _saveSelectedTheme(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme);
    setState(() {
      _selectedTheme = theme;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSelectedTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.brightness_6),
      title: const Text('Theme'),
      subtitle:
          Text(_selectedTheme[0].toUpperCase() + _selectedTheme.substring(1)),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),
                    const Text('Choose theme'),
                    const SizedBox(height: 4),
                    RadioListTile(
                      value: 'system',
                      title: const Text('System'),
                      groupValue: _selectedTheme,
                      onChanged: (value) {
                        _changeTheme(value ?? 'system');
                      },
                    ),
                    RadioListTile(
                      value: 'light',
                      title: const Text('Light'),
                      groupValue: _selectedTheme,
                      onChanged: (value) {
                        _changeTheme(value ?? 'light');
                      },
                    ),
                    RadioListTile(
                      value: 'dark',
                      title: const Text('Dark'),
                      groupValue: _selectedTheme,
                      onChanged: (value) {
                        _changeTheme(value ?? 'dark');
                      },
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Save'),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            });

        /*
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),
                    RadioListTile(
                      value: 'system',
                      title: const Text('System'),
                      groupValue: _selectedTheme,
                      onChanged: (value) {
                        _changeTheme(value ?? 'system');
                      },
                    ),
                    RadioListTile(
                      value: 'light',
                      title: const Text('Light'),
                      groupValue: _selectedTheme,
                      onChanged: (value) {
                        _changeTheme(value ?? 'light');
                      },
                    ),
                    RadioListTile(
                      value: 'dark',
                      title: const Text('Dark'),
                      groupValue: _selectedTheme,
                      onChanged: (value) {
                        _changeTheme(value ?? 'dark');
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        );
        */
      },
    );
  }
}
