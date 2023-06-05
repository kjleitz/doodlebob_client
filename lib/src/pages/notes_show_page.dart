import "package:doodlebob_client/src/layouts/note_editor_layout.dart";
import "package:flutter/material.dart";

import "../schemata/notes.dart";

class NotesShowPage extends StatelessWidget {
  final NoteResource note;

  late final TextEditingController _titleController =
      TextEditingController(text: note.attributes.title);
  late final TextEditingController _bodyController =
      TextEditingController(text: note.attributes.body);

  NotesShowPage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return NoteEditorLayout(
      note: note,
      child: Column(
        children: [
          TextField(controller: _titleController),
          TextField(controller: _bodyController),
        ],
      ),
    );
  }
}
