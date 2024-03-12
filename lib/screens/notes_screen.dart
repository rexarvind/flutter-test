import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/note_controller.dart';
import '../controllers/auth_controller.dart';
import '../screens/auth_screen.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({super.key});
  final _noteController = Get.put(NoteController());
  final _authController = Get.put(AuthController());

  Future<void> _loadNotes() async {
    await _noteController.getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          IconButton(
            onPressed: _loadNotes,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: _authController.isLoggedIn.value
            ? ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _noteController.notes.length,
                itemBuilder: (ctx, index) {
                  return ListTile(
                    leading: const Icon(Icons.notes),
                    title: Text(_noteController.notes[index].name),
                    subtitle: Text(_noteController.notes[index].updatedAt),
                    trailing: _noteController.notes[index].isFavorite
                        ? const Icon(Icons.push_pin)
                        : null,
                    onTap: () {},
                  );
                })
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.to(
                        () => AuthScreen(),
                        preventDuplicates: true,
                      );
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
      ),
    );
  }
}



// RefreshIndicator(
//                 onRefresh: _loadNotes,
//                 triggerMode: RefreshIndicatorTriggerMode.anywhere,
//                 child: 