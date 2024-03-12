import 'package:get/get.dart';

import '../models/note.dart';
import '../services/api.dart';
import '../responses/note_response.dart';

class NoteController extends GetxController {
  var notes = <Note>[].obs;
  var isLoadingNotes = true.obs;

  Future<void> getNotes() async {
    isLoadingNotes.value = true;
    var response = await Api.getNotes();
    var noteResponse = NoteResponse.fromJson(response.data);
    notes.clear();
    notes.addAll(noteResponse.notes);
    isLoadingNotes.value = false;
  }
}
