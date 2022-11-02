import 'dart:convert';
import 'dart:developer';

import 'package:notes/models/note.dart';
import 'package:http/http.dart' as http;

class ApiService{
  static const String _baseUrl = 'https://notesapi.up.railway.app/notes';

  static Future<List<Note>> getNotes(String userid) async {
    Uri requestUri = Uri.parse('$_baseUrl/list');
    final response = await http.post(requestUri, body: {'userid': userid});
    var decoded = jsonDecode(response.body);
    log(decoded.toString());

    List<Note> notes = [];

    for(var noteMap in decoded){
      Note newNote = Note.fromMap(noteMap);
      notes.add(newNote);
    }

    return notes;
  }

  static Future<void> addNote(Note note) async{
    Uri requestUri = Uri.parse("$_baseUrl/add");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  static Future<void> deleteNote(Note note) async{
    Uri requestUri = Uri.parse("$_baseUrl/delete");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

}