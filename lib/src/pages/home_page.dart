import "package:doodlebob_client/src/widgets/nav_drawer.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../state/app_state.dart";
import "../utilities/destination.dart";
import "notes_page.dart";
import "reminders_page.dart";

final mainDestinations = <Destination>[
  Destination(
    label: "All notes",
    icon: Icons.note_outlined,
    selectedIcon: Icons.note,
    target: () => const NotesPage(),
  ),
  Destination(
    label: "Reminders",
    icon: Icons.alarm_outlined,
    selectedIcon: Icons.alarm,
    target: () => const RemindersPage(),
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  Destination currentDestination = mainDestinations[0];

  @override
  void dispose() {
    // TODO: implement. See doc text on `super.dispose()` for good tip on
    //  lifecycle management of `appState` object itself, too.
    // appState.cancelSearch();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var labels = appState.labels;

    var labelDestinations = <Destination>[
      for (var label in labels)
        Destination(
          label: label.name,
          icon: Icons.label_outline,
          selectedIcon: Icons.label,
          target: () => NotesPage(
            key: ValueKey(label.name),
            labelData: label,
          ),
        ),
    ];

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: "Search notes...",
              border: InputBorder.none,
            ),
            onChanged: (value) {
              appState.updateSearchText(value);
            },
          ),
        ),
        drawer: NavDrawer(
          sections: [mainDestinations, labelDestinations],
          onDestinationSelected: (dest) {
            setState(() {
              currentDestination = dest;
              Navigator.pop(context);
            });
          },
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: currentDestination.target(),
        ),
        // body: Row(
        //   children: [
        //     // SafeArea(
        //     //   child: NavigationRail(
        //     //     extended: constraints.maxWidth >= 600,
        //     //     destinations: const [
        //     //       NavigationRailDestination(
        //     //         icon: Icon(Icons.home),
        //     //         label: Text("Home"),
        //     //       ),
        //     //       NavigationRailDestination(
        //     //         icon: Icon(Icons.favorite),
        //     //         label: Text("Favorites"),
        //     //       ),
        //     //     ],
        //     //     selectedIndex: selectedIndex,
        //     //     onDestinationSelected: (index) {
        //     //       setState(() {
        //     //         selectedIndex = index;
        //     //       });
        //     //     },
        //     //   ),
        //     // ),
        //     Expanded(
        //       child: Container(
        //         color: Theme.of(context).colorScheme.primaryContainer,
        //         // child: target,
        //         child: AnimatedSwitcher(
        //           duration: const Duration(milliseconds: 200),
        //           child: currentDestination,
        //         ),
        //       ),
        //     )
        //   ],
        // ),
      );
    });
  }
}
