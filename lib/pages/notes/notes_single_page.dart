import 'package:flutter/material.dart';

class NotesEditPage extends StatelessWidget {
  const NotesEditPage(
      {super.key, this.title = 'Create New Note', this.action = 'create'});

  final String title;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: action == 'view'
            ? [
                IconButton(
                  onPressed: () {},
                  tooltip: 'Delete',
                  icon: const Icon(Icons.delete),
                ),
              ]
            : [],
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Text('hello'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (action == 'view') {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (ctx) => const NotesEditPage(
                        title: 'Edit',
                        action: 'edit',
                      )),
            );
          } else if (action == 'edit') {
          } else if (action == 'create') {}
        },
        tooltip: action == 'view' ? 'edit' : 'save',
        child: Icon(action == 'view' ? Icons.edit : Icons.save),
      ),
    );
  }
}
