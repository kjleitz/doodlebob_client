import "package:flutter/material.dart";

class Scrim extends StatelessWidget {
  final bool enabled;
  final Widget child;

  final double opacity;
  final Duration animationDuration;
  final Color color;

  const Scrim({
    super.key,
    required this.enabled,
    required this.child,
    this.opacity = 0.75,
    this.color = Colors.transparent,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: enabled,
      child: AnimatedContainer(
        duration: animationDuration,
        curve: const Interval(0.0, 0.4, curve: Curves.easeInOut),
        foregroundDecoration: BoxDecoration(
          color: color.withOpacity(enabled ? opacity : 0.0),
        ),
        child: child,
      ),
    );
  }
}
