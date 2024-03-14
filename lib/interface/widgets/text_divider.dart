import 'package:flutter/material.dart';

class TextDivider extends StatelessWidget {
  final String text;
  final double thickness;
  final double indent;
  final Color? color;
  final double? fontSize;

  const TextDivider(
      {super.key,
      required this.text,
      this.color,
      this.thickness = 1.0,
      this.indent = 50,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    final dividerColor = color ?? Theme.of(context).colorScheme.onBackground;

    return Row(
      children: [
        Expanded(
          child: Divider(
            indent: indent,
            color: dividerColor,
            thickness: thickness,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, color: dividerColor),
          ),
        ),
        Expanded(
          child: Divider(
            endIndent: indent,
            color: dividerColor,
            thickness: thickness,
          ),
        ),
      ],
    );
  }
}
