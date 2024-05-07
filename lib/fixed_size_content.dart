import 'package:flutter/material.dart';

class FixedSizeListItem extends StatelessWidget {
  const FixedSizeListItem({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Icons.music_note,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(icon),
      ),
    );
  }

  static const height = 50.0;
}
