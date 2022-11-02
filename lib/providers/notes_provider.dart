import 'package:flutter/cupertino.dart';
import 'package:notes/models/note.dart';
import 'package:notes/services/api_service.dart';

class NotesProvider with ChangeNotifier {
  bool isLoading = true;
  List<Note> notes = [];

  NotesProvider() {
    getNotes();
  }

  void sortNotes() {
    notes.sort((a, b) => b.dateadded!.compareTo(a.dateadded!));
  }

  void getNotes() async{
    notes = await ApiService.getNotes("rudrankbasant");
    sortNotes();
    isLoading = false;
    notifyListeners();
  }

  List<Note> getFilteredNotes(String query) {
    return notes.where((note) => note.title!.toLowerCase().contains(query.toLowerCase())
        || note.content!.toLowerCase().contains(query.toLowerCase())).toList();
  }

  void addNote(Note note) {
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void updateNote(Note note) {
    final noteIndex = notes.indexWhere((element) => element.id == note.id);
    notes[noteIndex] = note;
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void deleteNote(Note note) {
    final noteIndex = notes.indexWhere((element) => element.id == note.id);
    notes.removeAt(noteIndex);
    sortNotes();
    notifyListeners();
    ApiService.deleteNote(note);
  }
}