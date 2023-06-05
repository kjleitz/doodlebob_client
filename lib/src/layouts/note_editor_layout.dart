import "package:doodlebob_client/src/schemata/notes.dart";
import "package:doodlebob_client/src/widgets/app_bars/note_actions_app_bar.dart";
import "package:flutter/material.dart";

class NoteEditorLayout extends StatelessWidget {
  final Widget child;
  final NoteResource note;

  const NoteEditorLayout({super.key, required this.child, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NoteActionsAppBar(note: note),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: child,
      ),
    );
  }
}
