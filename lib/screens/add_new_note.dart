import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNewNote extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddNewNote({Key? key, required this.isUpdate, this.note}) : super(key: key);

  @override
  _AddNewNoteState createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  //NotesProvider notesProvider = Provider.of<NotesProvider>(context);
  FocusNode noteFocus = FocusNode();

  void addNewNote() {
    Note newNote = Note(
      id: const Uuid().v1(),
      userid: "rudrankbasant",
      title: titleController.text,
      content: contentController.text,
      dateadded: DateTime.now(),
    );

    Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
    Navigator.pop(context);
  }

  void updateNote() {
    Note updatedNote = Note(
      id: widget.note!.id,
      userid: widget.note!.userid,
      title: titleController.text,
      content: contentController.text,
      dateadded: DateTime.now(),
    );

    Provider.of<NotesProvider>(context, listen: false).updateNote(updatedNote);
    Navigator.pop(context);
  }

  @override
  void initState() {
    if (widget.isUpdate) {
      titleController.text = widget.note!.title.toString();
      contentController.text = widget.note!.content.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Visibility(
            visible: widget.isUpdate,
            child: IconButton(
              onPressed: () {
                if(widget.isUpdate){
                  Provider.of<NotesProvider>(context, listen: false).deleteNote(widget.note!);
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.delete),
            ),
          ),
          IconButton(
            onPressed: (){
              if(widget.isUpdate) {
                updateNote();
              }else{
                addNewNote();
              }
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('Title'),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: titleController,
                autofocus:  widget.isUpdate? false : true,
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    noteFocus.requestFocus();
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Title',
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Content'),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                height: 500,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: contentController,
                  focusNode: noteFocus,
                  minLines: 15,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Note',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}