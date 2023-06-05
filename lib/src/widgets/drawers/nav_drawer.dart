import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../state/app_state.dart";
import "../../utilities/destination.dart";

List<Widget> createSectionItems(List<List<Destination>> sections) {
  final widgets = <Widget>[];

  for (final section in sections) {
    if (widgets.isNotEmpty) widgets.add(const Divider());

    for (final Destination(:label, :icon, :selectedIcon) in section) {
      widgets.add(NavigationDrawerDestination(
        icon: Icon(icon),
        label: Text(label),
        selectedIcon: Icon(selectedIcon),
      ));
    }
  }

  return widgets;
}

Destination getDrawerDestination(
    final int index, List<List<Destination>> sections) {
  var sectionIndex = index;

  for (final section in sections) {
    if (sectionIndex < section.length) return section[sectionIndex];
    sectionIndex -= section.length;
  }

  throw IndexError.withLength(index, index - sectionIndex);
}

class NavDrawer extends StatefulWidget {
  final List<List<Destination>> sections;
  final void Function(Destination dest)? onDestinationSelected;

  const NavDrawer({
    super.key,
    required this.sections,
    this.onDestinationSelected,
  });

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final onDestinationSelected = widget.onDestinationSelected;
    // final currentUser = appState.currentUser;

    // final drawerHeader = currentUser == null
    //     ? const DrawerHeader(child: Text("Doodlebob"))
    //     : UserAccountsDrawerHeader(
    //         accountName: Text(currentUser.attributes.username),
    //         accountEmail: Text(currentUser.attributes.email),
    //       );

    return SafeArea(
      child: NavigationDrawer(
        selectedIndex: appState.currentDestinationIndex,
        onDestinationSelected: (value) {
          appState.setCurrentDestinationIndex(value);

          if (onDestinationSelected != null) {
            final dest = getDrawerDestination(value, widget.sections);
            onDestinationSelected(dest);
          }

          Scaffold.of(context).closeDrawer();
        },
        children: [
          // drawerHeader,
          UserAccountsDrawerHeader(
            accountName: const Text("logged out"),
            accountEmail: const Text("logged out"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
              child: const Text("?"),
            ),
            onDetailsPressed: () {
              print("pressed");
            },
          ),
          // const SizedBox(
          //   height: 72,
          //   child: DrawerHeader(
          //     padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
          //     child: Align(
          //       alignment: Alignment.centerLeft,
          //       child: Text("Doodlebob"), // TODO: Doodlebob logo/branding
          //     ),
          //   ),
          // ),
          ...createSectionItems(widget.sections),
        ],
      ),
    );
  }
}
