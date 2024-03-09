import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_app/noteModel.dart';
import 'package:note_app/noteService.dart';
import 'package:note_app/notelistView.dart';

class CreateNote extends StatefulWidget {
  final String title;
  const CreateNote({Key? key, required this.title}) : super(key: key);

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  late Future noteservice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 105),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please enter title';
                    else if (value.length < 3)
                      return 'Title should be at least 3 characters';
                    else if (value.length > 20)
                      return 'Title should be at most 20 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _contentController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String title = _titleController.text;
                    String content = _contentController.text;

                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Note Created Successfully!')),
                      );
                      print(title);
                      print(content);
                      NoteService().createNote(
                        title: title,
                        content: content,
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ListNoteView(
                            title: 'Flutter Demo Notes List',
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
