import "dart:math";

import "package:doodlebob_client/src/state/app_state.dart";
import "package:flutter/material.dart";
import "package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart";
import "package:provider/provider.dart";

import "../entities/label_data.dart";
import "../widgets/note_card.dart";

class NotesPage extends StatefulWidget {
  final LabelData? labelData;

  const NotesPage({super.key, this.labelData});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  var isLoadingNotes = false;
  var attemptedToPopulateNotes = false;

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final currentLabel = appState.currentLabel;
    final notes = appState.notes;
    final labelData = widget.labelData;

    if (!isLoadingNotes &&
        (currentLabel?.name != labelData?.name ||
            notes.isEmpty && !attemptedToPopulateNotes)) {
      if (labelData == null) {
        populateNotes(appState);
      } else {
        populateNotesForLabel(labelData, appState);
      }
    }

    if (isLoadingNotes) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Loading notes..."),
            SizedBox(height: 16),
            CircularProgressIndicator(semanticsLabel: "Loading notes..."),
          ],
        ),
      );
    }

    Size size = MediaQuery.sizeOf(context);
    double width = size.width;
    double minCardWidth = 200.0;
    int columnCount = max(width ~/ minCardWidth, 1);

    return MasonryGridView.count(
      crossAxisCount: columnCount,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemCount: notes.length,
      itemBuilder: (context, index) {
        var note = notes[index];
        return NoteCard(
          key: ValueKey(note.id),
          title: note.attributes.title,
          body: note.attributes.body,
        );
      },
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
