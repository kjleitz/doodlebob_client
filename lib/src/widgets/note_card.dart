import "package:flutter/material.dart";

class NoteCard extends StatelessWidget {
  final String title;
  final String body;

  const NoteCard({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
