import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:note_app/noteModel.dart';


class NoteService {
  final String url = 'http://127.0.0.1:8000';
// retreive data from the server #GET
  Future<List<Note>> retrieveNote() async {
    final response = await http.get(Uri.parse('$url/notes'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Note> notes =
          body.map((dynamic item) => Note.fromJson(item)).toList();
      return notes;
    } else {
      throw 'Failed to load notes';
    }
  }
// create data on the server #POST
  Future<Note> createNote(
      {required String title, required String content}) async {
    final response = await http.post(
      Uri.parse('$url/notes/create/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'title': title, 'content': content}),
    );
    if (response.statusCode == 201) {
      return Note.fromJson(jsonDecode(response.body));
    } else {
      throw 'Failed to create note';
    }
  } 

// update data on the server #PUT
  Future<Note> updateNote(
      {required int id, required String title, required String content}) async {
    final response = await http.put(
      Uri.parse('$url/notes/$id/update/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'title': title, 'content': content}),
    );
    if (response.statusCode == 200) {
      return Note.fromJson(jsonDecode(response.body));
    } else {
      throw 'Failed to update note';
    }
  }

// delete data on the server #DELETE
  Future<void> deleteNote(int id) async {
    final response = await http.delete(
      Uri.parse('$url/notes/$id/delete/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode != 204) {
      throw 'Failed to delete note';
    }
  }

}
