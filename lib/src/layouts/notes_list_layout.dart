import "package:doodlebob_client/src/state/app_state.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../widgets/drawers/main_nav_drawer.dart";
import "../widgets/app_bars/search_app_bar.dart";

class NotesListLayout extends StatelessWidget {
  final Widget child;

  const NotesListLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      appBar: SearchAppBar(
        onChanged: (value) {
          appState.updateSearchText(value);
        },
      ),
      drawer: const MainNavDrawer(),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: child,
      ),
    );
  }
}
