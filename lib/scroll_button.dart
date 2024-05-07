import 'package:flutter/material.dart';

class ScrollButton extends StatelessWidget {
  const ScrollButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      label: const Text('Scroll'),
      icon: const Icon(Icons.arrow_forward),
    );
  }
}
