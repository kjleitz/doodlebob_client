import "dart:math";

import "package:doodlebob_client/src/layouts/notes_list_layout.dart";
import "package:doodlebob_client/src/pages/notes_show_page.dart";
import "package:doodlebob_client/src/state/app_state.dart";
import "package:flutter/material.dart";
import "package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart";
import "package:provider/provider.dart";

import "../entities/label_data.dart";
import "../widgets/note_card.dart";

class NotesIndexPage extends StatefulWidget {
  final LabelData? labelData;

  const NotesIndexPage({super.key, this.labelData});

  @override
  State<NotesIndexPage> createState() => _NotesIndexPageState();
}

class _NotesIndexPageState extends State<NotesIndexPage> {
  var isLoadingNotes = false;
  var attemptedToPopulateNotes = false;

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final currentLabel = appState.currentLabel;
    final notes = appState.notes;
    final labelData = widget.labelData;

    print("=== ${widget.key} ===");
    // print("isLoadingNotes: $isLoadingNotes");
    // print("currentLabel: $currentLabel");
    // print("notes.isEmpty: ${notes.isEmpty}");
    // print("attemptedToPopulateNotes: $attemptedToPopulateNotes");
    if (!isLoadingNotes &&
        (currentLabel?.name != labelData?.name ||
            notes.isEmpty && !attemptedToPopulateNotes)) {
      if (labelData == null) {
        print("populating... (without label)");
        populateNotes(appState);
      } else {
        print("populating... (with label)");
        populateNotesForLabel(labelData, appState);
      }
    } else {
      print("not populating");
    }

    if (isLoadingNotes) {
      return const NotesListLayout(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Loading notes..."),
              SizedBox(height: 16),
              CircularProgressIndicator(semanticsLabel: "Loading notes..."),
            ],
          ),
        ),
      );
    }

    Size size = MediaQuery.sizeOf(context);
    double width = size.width;
    double minCardWidth = 200.0;
    int columnCount = max(width ~/ minCardWidth, 1);

    return NotesListLayout(
      child: MasonryGridView.count(
        crossAxisCount: columnCount,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemCount: notes.length,
        itemBuilder: (context, index) {
          var note = notes[index];
          return GestureDetector(
            child: NoteCard(
              key: ValueKey(note.id),
              note: note,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (_) => NotesShowPage(note: note),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // TODO: real implementation needs debounce
  Future<void> populateNotes(AppState appState) async {
    isLoadingNotes = true;
    attemptedToPopulateNotes = true;

    final notes = await Future.delayed(
        const Duration(milliseconds: 1500),
        () => [
              ...generateDummyNotes(),
              ...generateDummyNotes(),
              ...generateDummyNotes(),
            ]);

    isLoadingNotes = false;
    appState.setNotes(notes);
  }

  // TODO: real implementation needs debounce
  Future<void> populateNotesForLabel(LabelData label, AppState appState) async {
    isLoadingNotes = true;
    attemptedToPopulateNotes = true;

    final notes = await Future.delayed(const Duration(milliseconds: 1500), () {
      final shuffledNotes = [...generateDummyNotes()];
      shuffledNotes.shuffle();
      return shuffledNotes.take(3).toList();
    });

    isLoadingNotes = false;
    appState.setNotesByLabel(notes, label);
  }
}
