import 'package:flutter/material.dart';

class FloatingButtonWork extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Icon icon;
  const FloatingButtonWork({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      label: Text(label),
      icon: icon,
    );
  }
}
