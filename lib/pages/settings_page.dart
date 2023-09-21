import 'package:flutter/material.dart';

import '../widgets/settings/theme_toggle.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SwitchListTile(
              value: true,
              onChanged: (isChecked) {},
              title: const Text('Gluten-free'),
              subtitle: const Text('Only included gluten free meals'),
            ),
            const ThemeToggle(),
          ],
        ),
      ),
    );
  }
}
