import 'package:flutter/material.dart';

// How to use: AppTheme.*
// Example: AppTheme.primaryColor
// Example: AppTheme.textTheme.titleLarge

class AppTheme {
  static const Color primaryColor = Color(0xFF2B90D7);
  static const Color primaryColorLight = Color(0xFF4EACF0);
  static const Color primaryColorLighter = Color(0xFFC5F1FF);
  static const Color primaryColorDark = Color(0xFF2275B0);
  static const Color primaryColorDarker = Color(0xFF1C6497);
  static const Color secondaryColor = Color(0xFF2BD76D);
  static const Color secondaryColorLight = Color(0xFF5AF595);
  static const Color secondaryColorLighter = Color(0xFF81FFB2);
  static const Color secondaryColorDark = Color(0xFF1A984A);
  static const Color secondaryColorDarker = Color(0xFF137639);
  static const Color accentColor = Color(0xFF6225C3);
  static const Color accentColorLight = Color(0xFF8345E7);
  static const Color accentColorLighter = Color(0xFF9E61FF);
  static const Color accentColorDark = Color(0xFF4C1B9B);
  static const Color accentColorDarker = Color(0xFF401486);
  static const Color warningColor = Color(0xFFD7BE2B);
  static const Color warningColorLight = Color(0xFFF3D83E);
  static const Color warningColorLighter = Color(0xFFFFE96B);
  static const Color warningColorDark = Color(0xFFB09B21);
  static const Color warningColorDarker = Color(0xFF938117);
  static const Color errorColor = Color(0xFFB32628);
  static const Color errorColorLight = Color(0xFFEB3639);
  static const Color errorColorLighter = Color(0xFFFA4E51);
  static const Color errorColorDark = Color(0xFF861719);
  static const Color errorColorDarker = Color(0xFF681318);
  static const Color backgroundColor = Color(0xFF0C0F13);
  static const Color backgroundSecondaryColor = Color(0xFF12161B);

  static const Color white100 = Color(0xFFFFFFFF);
  static const Color white90 = Color(0xFFEEEEEE);
  static const Color white60 = Color(0xFFAAAAAA);
  static const Color white30 = Color(0xFF556072);
  static const Color white10 = Color(0xFF1E242C);

  static const Color textPrimaryColor = AppTheme.white100;
  static const Color textSecondaryColor = AppTheme.white90;
  static const Color hintColor = AppTheme.white60;
  static const Color cursorColor = AppTheme.primaryColor;


  static CustomTextTheme textTheme = CustomTextTheme();

  static ThemeData getThemeData() {
    return ThemeData(
        useMaterial3: true,
        primaryColor: AppTheme.primaryColor,
        primaryColorLight: AppTheme.primaryColorLight,
        primaryColorDark: AppTheme.primaryColorDark,
        scaffoldBackgroundColor: AppTheme.backgroundColor,
        hintColor: AppTheme.hintColor,
        textTheme: TextTheme(
          // Title
          titleLarge: AppTheme.textTheme.titleLarge,
          titleMedium: AppTheme.textTheme.titleMedium,
          titleSmall: AppTheme.textTheme.titleSmall,

          // Body
          bodyLarge: AppTheme.textTheme.bodyLarge,
          bodyMedium: AppTheme.textTheme.bodyMedium,
          bodySmall: AppTheme.textTheme.bodySmall,

          // Label
          labelLarge: AppTheme.textTheme.labelLarge,
          labelMedium: AppTheme.textTheme.labelMedium,
          labelSmall: AppTheme.textTheme.labelSmall,
        ));
  }
}

class CustomTextTheme {
  TextStyle titleLarge = const TextStyle(
    fontFamily: 'Outfit',
    color: AppTheme.textPrimaryColor,
    fontSize: 50,
    fontWeight: FontWeight.w600,
  );

  TextStyle titleMedium = const TextStyle(
    fontFamily: 'Outfit',
    color: AppTheme.textPrimaryColor,
    fontSize: 36,
    fontWeight: FontWeight.w600,
  );

  TextStyle titleSmall = const TextStyle(
    fontFamily: 'Outfit',
    color: AppTheme.textPrimaryColor,
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );

  TextStyle bodyLarge = const TextStyle(
    fontFamily: 'Outfit',
    color: AppTheme.textSecondaryColor,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  TextStyle bodyMedium = const TextStyle(
    fontFamily: 'Outfit',
    color: AppTheme.textSecondaryColor,
    fontSize: 18,
    fontWeight: FontWeight.w300,
  );

  TextStyle bodySmall = const TextStyle(
    fontFamily: 'Outfit',
    color: AppTheme.hintColor,
    fontSize: 15,
    fontWeight: FontWeight.w300,
  );

  TextStyle labelLarge = const TextStyle(
    fontFamily: 'Outfit',
    color: AppTheme.textSecondaryColor,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  TextStyle labelMedium = const TextStyle(
    fontFamily: 'Outfit',
    color: AppTheme.textSecondaryColor,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  TextStyle labelSmall = const TextStyle(
    fontFamily: 'Outfit',
    color: AppTheme.textSecondaryColor,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
}
