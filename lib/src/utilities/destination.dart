import "package:flutter/material.dart";

class Destination {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final Widget Function() target;

  const Destination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.target,
  });
}
