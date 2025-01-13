import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final double padding;
  final Color foregroundColor;
  final Color textButtonColor;
  final double fontSize;
  final String textButton;
  final String? images; // Properti images menjadi opsional
  final double height;
  final BorderSide? side;
  final VoidCallback onPressed;
  final Color? backgroundColor;

  const MyButton({
    super.key,
    required this.padding,
    required this.foregroundColor,
    required this.fontSize,
    required this.textButton,
    this.images,
    required this.height,
    required this.textButtonColor,
    required this.onPressed,
    this.backgroundColor, this.side,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(padding),
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          side: side,
      ),
      onPressed: onPressed,
      label: Text(
        textButton,
        style: TextStyle(
          color: textButtonColor,
          fontSize: fontSize,
        ),
      ),
      icon: images != null
          ? Image.asset(images!, height: height, fit: BoxFit.cover)
          : const SizedBox.shrink(),
    );
  }
}
