import '../models/note.dart';

class NoteResponse {
  List<Note> notes = [];

  NoteResponse.fromJson(Map<String, dynamic> json){
    json['items'].forEach((note) => notes.add(Note.fromJson(note)));
  }
}