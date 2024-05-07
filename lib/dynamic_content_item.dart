import 'package:flutter/material.dart';

class DynamicContentListItem extends StatelessWidget {
  const DynamicContentListItem(this.content, {super.key});

  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(padding),
          child: RichText(text: TextSpan(text: content, style: defaultStyle)),
        ),
        const Divider(height: dividerHeight),
      ],
    );
  }

  static const TextStyle defaultStyle = TextStyle(
    fontSize: 22,
    color: Colors.black,
  );

  static const dividerHeight = 1.0;

  static const padding = 4.0;

  static double getHeight(
    String content, {
    TextStyle style = DynamicContentListItem.defaultStyle,
    double maxWidth = double.infinity,
  }) {
    final text = TextSpan(
      text: content,
      style: defaultStyle,
    );

    final textPainter = TextPainter(
      text: text,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    );

    textPainter.layout(maxWidth: maxWidth);

    return textPainter.height + padding * 2 + dividerHeight;
  }
}
