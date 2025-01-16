import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum SpinnerSize { small, medium, large }
class SpinnerWidget extends StatelessWidget {

  final SpinnerSize size;

  const SpinnerWidget({
    super.key,
    required this.size
  });

  double checkSize(SpinnerSize size) {
    switch (size) {
      case SpinnerSize.small:
        return 24;
      case SpinnerSize.medium:
        return 32;
      case SpinnerSize.large:
        return 48;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoopAnimationBuilder(
      duration: const Duration(milliseconds: 800),
      tween: Tween(begin: 0.0, end: 2 * pi),
      builder: (context, value, _) {
        return Transform.rotate(
          angle: value,
          child: Image.asset('assets/icons/spinner.png',
            width: checkSize(size), height: checkSize(size),
          ),
        );
      }
    );
  }
}