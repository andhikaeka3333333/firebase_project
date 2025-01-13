import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final double padding;
  final Color foregroundColor;
  final Color textButtonColor;
  final double fontSize;
  final String textButton;
  final String images;
  final double height;
  final VoidCallback onPressed;

  const MyButton(
      {super.key,
        required this.padding,
        required this.foregroundColor,
        required this.fontSize,
        required this.textButton,
        required this.images,
        required this.height,
        required this.textButtonColor,
        required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.all(padding),
        foregroundColor: foregroundColor,
      ),
      onPressed: onPressed,
      label: Text(
        textButton,
        style: TextStyle(
          color: textButtonColor,
          fontSize: fontSize,
        ),
      ),
      icon: Image.asset(images, height: height, fit: BoxFit.cover),
    );
  }
}