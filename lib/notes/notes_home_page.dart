import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import './notes_single_page.dart';
import './notes_model.dart';
import './notes_list_item.dart';

class NotesHomePage extends ConsumerStatefulWidget {
  const NotesHomePage({super.key});
  static const routeName = '/notes';

  // List<Note> notes = [
  //   Note(title: 'ab', content: 'asf', isTagged: true, isFavorite: false, isDeleted: false),

  // ];

  @override
  ConsumerState<NotesHomePage> createState() => _NotesHomePageState();
}

class _NotesHomePageState extends ConsumerState<NotesHomePage> {
  List<Note> _notes = [
          Note(title: 'asdf', content: 'alsj', isTagged: false, isFavorite: false, isDeleted: true),
      Note(title: 'asdf', content: 'alsj', isTagged: false, isFavorite: false, isDeleted: true),
      Note(title: 'asdf', content: 'alsj', isTagged: false, isFavorite: false, isDeleted: true),
      Note(title: 'asdf', content: 'alsj', isTagged: false, isFavorite: false, isDeleted: true),
      Note(title: 'asdf', content: 'alsj', isTagged: false, isFavorite: false, isDeleted: true),
      Note(title: 'asdf', content: 'alsj', isTagged: false, isFavorite: false, isDeleted: true),
      Note(title: 'asdf', content: 'alsj', isTagged: false, isFavorite: false, isDeleted: true),
      Note(title: 'asdf', content: 'alsj', isTagged: false, isFavorite: false, isDeleted: true),
      Note(title: 'asdf', content: 'alsj', isTagged: false, isFavorite: false, isDeleted: true),
      Note(title: 'asdf', content: 'alsj', isTagged: false, isFavorite: false, isDeleted: true),
      Note(title: 'asdf', content: 'alsj', isTagged: false, isFavorite: false, isDeleted: true),
      Note(title: 'asdf', content: 'alsj', isTagged: false, isFavorite: false, isDeleted: true),
      Note(title: 'asdf', content: 'alsj', isTagged: false, isFavorite: false, isDeleted: true),
      Note(title: 'asdf', content: 'alsj', isTagged: false, isFavorite: false, isDeleted: true),
      Note(title: 'asdf', content: 'alsj', isTagged: false, isFavorite: false, isDeleted: true),
      Note(title: 'asdf', content: 'alsj', isTagged: false, isFavorite: false, isDeleted: true),
      Note(title: 'asdf', content: 'alsj', isTagged: false, isFavorite: false, isDeleted: true),
      Note(title: 'asdf', content: 'alsj', isTagged: false, isFavorite: false, isDeleted: true),
      Note(title: 'asdf', content: 'alsj', isTagged: false, isFavorite: false, isDeleted: true),
      Note(title: 'asdf', content: 'alsj', isTagged: false, isFavorite: false, isDeleted: true),
      Note(title: 'asdf', content: 'alsj', isTagged: false, isFavorite: false, isDeleted: true),
      Note(title: 'asdf', content: 'alsj', isTagged: false, isFavorite: false, isDeleted: true),
      Note(title: 'asdf', content: 'alsj', isTagged: false, isFavorite: false, isDeleted: true),
  ];
  var _isLoading = false;
  String? _error;

  void _loadItems() async {
    final url = Uri.https('rexarvind.firebaseio.com', 'shopping-list.json');
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Failed to fetch data.';
        });
      }
      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);
      final List<Note> loadedItems = [];
      // for (final item in listData.entries) {
      //   final category = categories.entries
      //       .firstWhere(
      //           (catItem) => catItem.value.title == item.value['category'])
      //       .value;
      //   loadedItems.add(
      //     GroceryItem(
      //       id: item.key,
      //       name: item.value['name'],
      //       quantity: item.value['quantity'],
      //       category: category,
      //     ),
      //   );
      // }
      setState(() {
        _notes = loadedItems;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Something went wrong, try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Notes'),
              Tab(text: 'Favorites'),
              Tab(text: 'Deleted'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: _notes.length,
                      itemBuilder: (ctx, index) {
                        return const NotesListItem();
                      }),
                )
              ],
            ),
            const Text('notes'),
            const Text('notes'),
          ],
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
      ),
    );
  }
}
