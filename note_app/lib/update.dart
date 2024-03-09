import 'package:flutter/material.dart';
import 'package:note_app/noteModel.dart';
import 'package:note_app/noteService.dart';

class EditNotePage extends StatefulWidget {
  
  final Note note; 

  const EditNotePage({Key? key, required this.note}) : super(key: key);

  @override
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder(),
            )),
           const  SizedBox(height: 16),
            TextFormField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Content', border: OutlineInputBorder()),
              maxLines: null,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                String newTitle = _titleController.text;
                String newContent = _contentController.text;

                try {
                  await NoteService().updateNote(
                    id: widget.note.id,
                    title: newTitle,
                    content: newContent,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                   const  SnackBar(content: Text('Note updated successfully')),
                  );
                  Navigator.pop(context); // Retour à la page précédente
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to update note: $error')),
                  );
                }
              },
              child: const Text('Update Note'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
