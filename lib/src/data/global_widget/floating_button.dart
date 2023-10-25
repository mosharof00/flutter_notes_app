import 'package:flutter/material.dart';


class FloatingButtonWork extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final dynamic icon;
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
      elevation: 10,
      backgroundColor: Colors.grey.shade800,
    );
  }
}
