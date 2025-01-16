import 'package:flutter/material.dart';

import '../utils/theme.dart';

class TextFieldWidget extends StatelessWidget {
  
  final String label;
  final TextEditingController controller;

  final bool? obscureText;
  final bool? disabled;
  final String? error;
  final TextInputType? keyboardType;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? hintColor;
  final Color? errorColor;
  final Color? iconColor;
  final Color? borderColor;
  final Color? cursorColor;
  final double? borderWidth;
  final double? borderRadius;

  const TextFieldWidget(
    this.label, 
    {
      required this.controller,
      this.obscureText,
      this.keyboardType,
      this.disabled,
      this.error,
      this.prefixIcon,
      this.suffixIcon,
      this.backgroundColor,
      this.foregroundColor,
      this.hintColor,
      this.errorColor,
      this.iconColor,
      this.cursorColor,
      this.borderColor,
      this.borderWidth,
      this.borderRadius,
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText ?? false,
      controller: controller,
      keyboardType: keyboardType,
      enabled: disabled != null ? disabled != true : true,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: hintColor ?? AppTheme.white60),
        errorText: error,
        errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: errorColor ?? AppTheme.errorColorLighter),
        prefixIcon: prefixIcon != null ? 
          Padding(padding: const EdgeInsets.only(left: 4), child: prefixIcon) : null,
        suffixIcon: suffixIcon != null ? 
          Padding(padding: const EdgeInsets.only(right: 4), child: suffixIcon) : null,
        prefixIconColor: iconColor ?? AppTheme.white100,
        suffixIconColor: iconColor ?? AppTheme.white100,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? AppTheme.white30, width: borderWidth ?? 2.0),
          borderRadius: BorderRadius.circular(borderRadius ?? 12.0)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? AppTheme.white30, width: borderWidth ?? 2.0),
          borderRadius: BorderRadius.circular(borderRadius ?? 12.0)
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? AppTheme.white30, width: borderWidth ?? 2.0),
          borderRadius: BorderRadius.circular(borderRadius ?? 12.0)
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorColor ?? AppTheme.errorColor, width: borderWidth ?? 2.0),
          borderRadius: BorderRadius.circular(borderRadius ?? 12.0)
        ),
        filled: backgroundColor != null && backgroundColor != Colors.transparent,
        fillColor: backgroundColor,
      ),
      style: AppTheme.textTheme.bodyMedium.copyWith(color: foregroundColor ?? AppTheme.white90),
      cursorColor: cursorColor ?? AppTheme.primaryColor,
    );
  }
}