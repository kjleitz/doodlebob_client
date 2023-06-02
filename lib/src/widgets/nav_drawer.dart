import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../state/app_state.dart";
import "../utilities/destination.dart";

List<Widget> createDrawerItems(List<List<Destination>> sections) {
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
  final void Function(Destination dest) onDestinationSelected;

  const NavDrawer(
      {super.key, required this.sections, required this.onDestinationSelected});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return NavigationDrawer(
      selectedIndex: appState.currentDestinationIndex,
      onDestinationSelected: (value) {
        appState.setCurrentDestinationIndex(value);
        final dest = getDrawerDestination(value, widget.sections);
        widget.onDestinationSelected(dest);
      },
      children: createDrawerItems(widget.sections),
    );
  }
}
