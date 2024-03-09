import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:note_app/create.dart';
import 'package:note_app/delete.dart';
import 'package:note_app/noteModel.dart';
import 'package:note_app/noteService.dart';
import 'package:note_app/update.dart';

class ListNoteView extends StatefulWidget {
  final String title;
  const ListNoteView({Key? key, required this.title}) : super(key: key);

  @override
  State<ListNoteView> createState() => _ListNoteViewState();
}

class _ListNoteViewState extends State<ListNoteView> {
  late Future<List<Note>> futureNote;
  List<Note> notes = [];

  @override
  void initState() {
    futureNote = NoteService().retrieveNote();
    futureNote.then((value) {
      setState(() {
        notes.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return Column(
            
            children: [
              ListTile(
                title: Text(notes[index].title),
                subtitle: Text(notes[index].content),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {

                         Future<Note> note = NoteService().updateNote(
                          id: notes[index].id,
                          title: notes[index].title,
                          content: notes[index].content);

                         Navigator.pushReplacement(context, 
                          MaterialPageRoute(builder: (context) => EditNotePage(note: notes[index])));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        NoteService().deleteNote(notes[index].id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Note Deleted'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                        Navigator.pushReplacement(context, 
                          MaterialPageRoute(builder: (context) => ListNoteView(title: 'Flutter Demo Notes List')));
                      },
                    ),
                    // ElevatedButton(onPressed: ()=> CreateNote(title: 'Create note'), child: Text('Add Note')),
                  ],  
                ),
              ),
              Divider(
                height: 2.0,
              ),
            ],
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateNote(title: 'Create note')),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      )
    );
  }
}
