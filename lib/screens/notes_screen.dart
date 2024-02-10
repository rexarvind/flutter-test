import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/note_controller.dart';
import '../controllers/auth_controller.dart';
import '../screens/auth_screen.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({super.key});
  final noteController = Get.put(NoteController());
  final _authController = Get.put(AuthController());

  Future<void> _loadNotes() async {
    await noteController.getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: SingleChildScrollView(
        child: _authController.isLoggedIn.value
            ? RefreshIndicator(
                onRefresh: _loadNotes,
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
                child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: noteController.notes.length,
                    itemBuilder: (ctx, index) {
                      return ListTile(
                        leading: const Icon(Icons.notes),
                        title: Text(noteController.notes[index].name),
                        subtitle: Text(noteController.notes[index].updatedAt),
                        trailing: noteController.notes[index].isFavorite
                            ? const Icon(Icons.push_pin)
                            : null,
                        onTap: () {},
                      );
                    }),
              )
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
