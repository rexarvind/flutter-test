import 'package:flutter_riverpod/flutter_riverpod.dart';

import './notes_model.dart';

class NotesNotifier extends StateNotifier<List<Note>> {
  NotesNotifier() : super([]);

  void fetchData(){
    state = [

    ];
  }

}



final notesProvider = StateNotifierProvider<NotesNotifier, List<Note>>((ref) {
  return NotesNotifier();
});