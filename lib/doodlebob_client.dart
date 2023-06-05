import "package:doodlebob_client/src/pages/notes_index_page.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "src/state/app_state.dart";

class DoodlebobClient extends StatelessWidget {
  const DoodlebobClient({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: "Doodlebob",
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        ),
        home: const NotesIndexPage(key: ValueKey("all_notes")),
      ),
    );
  }
}
