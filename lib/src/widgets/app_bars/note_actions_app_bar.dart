import "package:doodlebob_client/src/schemata/notes.dart";
import "package:flutter/material.dart";

class NoteActionsAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final NoteResource note;

  const NoteActionsAppBar({
    super.key,
    required this.note,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    // TODO: pinning
    // final isPinned = note.attributes.pinned;

    return AppBar(
      actions: [
        // isPinned
        //     ? IconButton(
        //         icon: const Icon(Icons.close),
        //         key: const ValueKey("close"),
        //         onPressed: () {
        //           // TODO: pinning
        //           // pinNote();
        //         },
        //       )
        //     : IconButton(
        //         icon: const Icon(Icons.search),
        //         key: const ValueKey("search"),
        //         onPressed: () {
        //           // TODO: pinning
        //           // unpinNote();
        //         },
        //       ),
        IconButton(
          icon: const Icon(Icons.push_pin_outlined),
          key: const ValueKey("pin_note"),
          onPressed: () {
            // TODO: pinning
            // pinNote();
          },
        ),
        IconButton(
          icon: const Icon(Icons.alarm_add),
          key: const ValueKey("add_reminder"),
          onPressed: () {
            // TODO: reminders
            // pinNote();
          },
        ),
        IconButton(
          icon: const Icon(Icons.alarm_add),
          key: const ValueKey("archive_note"),
          onPressed: () {
            // TODO: archive
            // pinNote();
          },
        ),
      ],
    );
  }
}
