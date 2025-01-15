import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final Color colors;
  final double? height;
  final String? fontFamily;
  final TextAlign? textAlign;
  final List<Shadow>? shadows;

  const MyText({
    super.key,
    required this.text,
    required this.fontSize,
    this.fontWeight,
    this.padding,
    required this.colors,
    this.height,
    this.fontFamily,
    this.textAlign,
    this.shadows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: fontFamily,
          color: colors,
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: height,
          shadows: shadows,
        ),
        textAlign: textAlign,
      ),
    );
  }
}
