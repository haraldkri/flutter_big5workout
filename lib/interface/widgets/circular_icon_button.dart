import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircularIconButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;
  final String semanticLabel;

  const CircularIconButton({super.key, required this.imagePath, required this.onTap, required this.semanticLabel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color.fromRGBO(0, 0, 0, 0.3), // Dark background color
          border: Border.all(
            color: Colors.black, // Black outline color
          ),
        ),
        child: SvgPicture.asset(
          imagePath,
          semanticsLabel: semanticLabel,
          height: 30,
          width: 30,
        ),
      ),
    );
  }
}
