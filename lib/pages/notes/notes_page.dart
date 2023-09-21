import 'package:flutter/material.dart';

import '../../notes/notes_single_page.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            onPressed: () {},
            tooltip: 'Search',
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.notes),
                title: const Text('Note 1'),
                subtitle: const Text('20 September 2023'),
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
              ),
              ListTile(
                leading: const Icon(Icons.notes),
                title: const Text('Note 1'),
                subtitle: const Text('20 September 2023'),
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
              ),
              ListTile(
                leading: const Icon(Icons.notes),
                title: const Text('Note 1'),
                subtitle: const Text('20 September 2023'),
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
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create New Note',
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => const NotesEditPage()),
          );
        },
      ),
    );
  }
}
