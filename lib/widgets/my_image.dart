import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  final String imageName;
  final EdgeInsets? margin;
  final double width;
  final double height;
  final double? borderRadius;
  final BoxFit? fit;

  const MyImage({
    super.key,
    required this.imageName,
    this.margin,
    required this.width,
    required this.height,
    this.borderRadius,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: margin,
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius??00),
          image: DecorationImage(
            fit: fit ,
            image: AssetImage(imageName),
          ),
        ),
      ),
    );
  }
}
