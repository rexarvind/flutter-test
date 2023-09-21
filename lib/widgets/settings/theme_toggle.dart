import 'package:demo_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeToggle extends ConsumerStatefulWidget {
  const ThemeToggle({super.key});

  @override
  ConsumerState<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends ConsumerState<ThemeToggle> {
  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = ref.watch(themeProvider);
    String theme = 'system';
    if (themeMode == ThemeMode.light) {
      theme = 'light';
    } else if (themeMode == ThemeMode.dark) {
      theme = 'dark';
    } else {
      theme = 'system';
    }
    return ListTile(
      leading: const Icon(Icons.brightness_6),
      title: const Text('Theme'),
      subtitle: Text(theme[0].toUpperCase() + theme.substring(1)),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return const ThemeToggleSheet();
            });
      },
    );
  }
}

class ThemeToggleSheet extends ConsumerStatefulWidget {
  const ThemeToggleSheet({super.key});

  @override
  ConsumerState<ThemeToggleSheet> createState() => _ThemeToggleSheetState();
}

class _ThemeToggleSheetState extends ConsumerState<ThemeToggleSheet> {
  String selectedTheme = 'system';

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = ref.read(themeProvider);
    if (themeMode == ThemeMode.light) {
      selectedTheme = 'light';
    } else if (themeMode == ThemeMode.dark) {
      selectedTheme = 'dark';
    } else {
      selectedTheme = 'system';
    }
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
            groupValue: selectedTheme,
            onChanged: (value) {
              Navigator.pop(context);
              setState(() {
                selectedTheme = ref
                    .watch(themeProvider.notifier)
                    .changeTheme(value ?? 'system');
              });
            },
          ),
          RadioListTile(
            value: 'light',
            title: const Text('Light'),
            groupValue: selectedTheme,
            onChanged: (value) {
              Navigator.pop(context);
              setState(() {
                selectedTheme = ref
                    .watch(themeProvider.notifier)
                    .changeTheme(value ?? 'light');
              });
            },
          ),
          RadioListTile(
            value: 'dark',
            title: const Text('Dark'),
            groupValue: selectedTheme,
            onChanged: (value) {
              Navigator.pop(context);
              setState(() {
                selectedTheme = ref
                    .watch(themeProvider.notifier)
                    .changeTheme(value ?? 'dark');
              });
            },
          ),
          // const SizedBox(height: 4),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     TextButton(
          //       onPressed: () {
          //         Navigator.pop(context);
          //       },
          //       child: const Text('Cancel'),
          //     ),
          //     const SizedBox(width: 8),
          //     TextButton(
          //       onPressed: () {
          //         Navigator.pop(context);
          //         ref.watch(themeProvider.notifier).changeTheme(selectedTheme);
          //       },
          //       child: const Text('Save'),
          //     ),
          //     const SizedBox(width: 20),
          //   ],
          // ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
