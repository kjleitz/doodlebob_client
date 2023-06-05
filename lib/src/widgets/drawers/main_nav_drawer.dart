import "package:doodlebob_client/src/widgets/drawers/nav_drawer.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../pages/notes_index_page.dart";
import "../../pages/reminders_page.dart";
import "../../state/app_state.dart";
import "../../utilities/destination.dart";

final mainDestinations = <Destination>[
  Destination(
    label: "All notes",
    icon: Icons.note_outlined,
    selectedIcon: Icons.note,
    target: () => const NotesIndexPage(key: ValueKey("all_notes")),
  ),
  Destination(
    label: "Reminders",
    icon: Icons.alarm_outlined,
    selectedIcon: Icons.alarm,
    target: () => const RemindersPage(),
  ),
];

class MainNavDrawer extends StatelessWidget {
  const MainNavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final labels = appState.labels;

    final labelDestinations = <Destination>[
      for (var label in labels)
        Destination(
          label: label.name,
          icon: Icons.label_outline,
          selectedIcon: Icons.label,
          target: () => NotesIndexPage(
            key: ValueKey(label.name),
            labelData: label,
          ),
        ),
    ];

    final destinationSections = [mainDestinations, labelDestinations];

    return NavDrawer(
      sections: destinationSections,
      onDestinationSelected: (destination) {
        print("onNavigationSelected");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(builder: (_) => destination.target()),
        );
      },
    );
  }
}
