import 'package:flutter/material.dart';

import '../utils/theme.dart';
import 'spinner_widget.dart';

enum ButtonVariant { primary, secondary, warning, danger, outline }

class ButtonWidget extends StatelessWidget {
  final String text;
  final ButtonVariant variant;
  final VoidCallback onPressed;
  bool? loading;

  Color? backgroundColor;
  Color? foregroundColor;
  Widget? prefixIcon;
  Widget? suffixIcon;
  double? borderWidth;
  Color? borderColor;
  double? borderRadius;
  FontWeight? fontWeight;
  EdgeInsetsGeometry? padding;
  double? width;
  TextStyle? textStyle;

  ButtonWidget(this.text,
      {required this.variant,
      required this.onPressed,
      this.loading,
      this.backgroundColor,
      this.foregroundColor,
      this.prefixIcon,
      this.suffixIcon,
      this.borderWidth,
      this.borderColor,
      this.borderRadius,
      this.fontWeight,
      this.padding,
      this.width,
      this.textStyle,
      super.key});

  @override
  Widget build(BuildContext context) {
    final data = variantCheck();
    if (backgroundColor != null) data.backgroundColor = backgroundColor;
    if (foregroundColor != null) data.foregroundColor = foregroundColor;
    if (borderWidth != null) data.borderWidth = borderWidth;
    if (borderColor != null) data.borderColor = borderColor;
    if (borderRadius != null) data.borderRadius = borderRadius;
    if (fontWeight != null) data.fontWeight = fontWeight;
    if (textStyle != null) data.textStyle = textStyle;

    return CustomButtonWidget(text,
        onPressed: onPressed,
        backgroundColor: data.backgroundColor,
        foregroundColor: data.foregroundColor,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        borderWidth: data.borderWidth,
        borderColor: data.borderColor,
        borderRadius: data.borderRadius,
        fontWeight: data.fontWeight,
        padding: padding,
        width: width,
        loading: loading,
        textStyle: data.textStyle);
  }

  variantCheck() {
    switch (variant) {
      case ButtonVariant.secondary:
        return CustomButtonWidget(text,
            onPressed: onPressed,
            backgroundColor: AppTheme.secondaryColor,
            foregroundColor: AppTheme.textPrimaryColor,
            borderRadius: 16.0,
            fontWeight: FontWeight.w600);

      case ButtonVariant.warning:
        return CustomButtonWidget(text,
            onPressed: onPressed,
            backgroundColor: AppTheme.warningColorDark,
            foregroundColor: AppTheme.textPrimaryColor,
            borderRadius: 16.0,
            fontWeight: FontWeight.w600);

      case ButtonVariant.danger:
        return CustomButtonWidget(text,
            onPressed: onPressed,
            backgroundColor: AppTheme.errorColorLight,
            foregroundColor: AppTheme.textPrimaryColor,
            borderRadius: 16.0,
            fontWeight: FontWeight.w600);

      case ButtonVariant.outline:
        return CustomButtonWidget(text,
            onPressed: onPressed,
            backgroundColor: Colors.transparent,
            foregroundColor: AppTheme.white100,
            borderWidth: 1.0,
            borderColor: AppTheme.white60,
            borderRadius: 16.0,
            fontWeight: FontWeight.w500);

      default:
        return CustomButtonWidget(text,
            onPressed: onPressed,
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: AppTheme.textPrimaryColor,
            borderRadius: 16.0,
            fontWeight: FontWeight.w600);
    }
  }
}

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  bool? loading = false;

  Color? backgroundColor = AppTheme.primaryColor;
  Color? foregroundColor = AppTheme.textPrimaryColor;
  Widget? prefixIcon;
  Widget? suffixIcon;
  double? borderWidth;
  Color? borderColor;
  double? borderRadius = 16.0; // fully rounded
  FontWeight? fontWeight = FontWeight.w500;
  EdgeInsetsGeometry? padding;
  double? width;
  TextStyle? textStyle;

  CustomButtonWidget(this.text,
      {required this.onPressed,
      this.loading,
      this.backgroundColor,
      this.foregroundColor,
      this.prefixIcon,
      this.suffixIcon,
      this.borderWidth,
      this.borderColor,
      this.borderRadius,
      this.fontWeight,
      this.padding,
      this.width,
      this.textStyle,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: loading == true ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppTheme.primaryColor,
          foregroundColor: foregroundColor ?? AppTheme.textPrimaryColor,
          disabledBackgroundColor: (backgroundColor ?? AppTheme.primaryColor)
              .withOpacity(0.7),
          disabledForegroundColor: (foregroundColor ?? AppTheme.textPrimaryColor)
              .withOpacity(0.7),
          side: BorderSide(
              color: borderColor ?? backgroundColor!,
              width: borderWidth ?? 0.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 100.0)),
          minimumSize: Size(width ?? double.infinity, 0),
          padding: padding ?? const EdgeInsets.symmetric(vertical: 16.0),
        ),
        child: loading == true
            ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0),
              child: SpinnerWidget(size: SpinnerSize.small),
            )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) prefixIcon!,
                  if (prefixIcon != null) const SizedBox(width: 12),
                  Text(
                    text,
                    style: textStyle ?? AppTheme.textTheme.bodyMedium!.copyWith(
                        color: foregroundColor ?? AppTheme.textPrimaryColor,
                        fontWeight: fontWeight ?? FontWeight.w500),
                  ),
                  if (suffixIcon != null) const SizedBox(width: 12),
                  if (suffixIcon != null) suffixIcon!,
                ],
              ));
  }
}
