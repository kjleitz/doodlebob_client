import "package:flutter/material.dart";

import "../schemata/notes.dart";

class NoteCard extends StatelessWidget {
  final NoteResource note;

  const NoteCard({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = note.attributes.title;
    final body = note.attributes.body;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (title.isNotEmpty)
              Text(title, style: theme.textTheme.titleMedium),
            if (body.isNotEmpty || title.isEmpty)
              Text(body, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
