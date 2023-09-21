import 'package:flutter/material.dart';

import './notes_single_page.dart';

class NotesListItem extends StatelessWidget {
  const NotesListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.notes),
      title: const Text('Note 1'),
      subtitle: const Text('20 September 2023'),
      trailing: const Icon(Icons.push_pin),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const NotesEditPage(
              title: 'View Note',
              action: 'view',
            ),
          ),
        );
      },
    );
  }
}
