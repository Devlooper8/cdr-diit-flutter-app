import 'package:flutter/material.dart';

class Themes {
  // Define the color constants
  static const Color primaryColor = Color(0xFF329ad1);
  static const Color accentColor = Color(0xFF1E88E5);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color backgroundColorLight = Color(0xFFFFFFFF);
  static const Color backgroundColorLightAlt = Color(0xFFe9f3f9);
  static const Color backgroundColorDark = Color(0xFF171717);
  static const Color cardColorLight = Color(0xFFFFFFFF);
  static const Color cardColorDark = Color(0xFF2f2f2f);
  static const Color textColorLight = Colors.black87;
  static const Color textColorDark = Colors.white70;
  static const Color greyColor = Colors.grey;

  // Light theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColorLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      iconTheme: IconThemeData(color: whiteColor),
      titleTextStyle: TextStyle(
        color: whiteColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: const IconThemeData(color: primaryColor),
    cardColor: cardColorLight,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textColorLight, fontSize: 16),
      bodyMedium: TextStyle(color: greyColor, fontSize: 14),
      headlineLarge: TextStyle(color: textColorLight, fontSize: 26, fontWeight: FontWeight.bold),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: whiteColor, backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    ), colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      onPrimary: whiteColor,
      secondary: accentColor,
      onSecondary: whiteColor,
      error: Colors.red,
      onError: whiteColor,
      surface: cardColorLight,
      onSurface: textColorLight,
    ).copyWith(surface: backgroundColorLightAlt),
  );

  // Dark theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColorDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent, // Make the appbar transparent in dark mode
      elevation: 0,
      iconTheme: IconThemeData(color: whiteColor),
      titleTextStyle: TextStyle(
        color: whiteColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: const IconThemeData(color: primaryColor),
    cardColor: cardColorDark,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textColorDark, fontSize: 16),
      bodyMedium: TextStyle(color: greyColor, fontSize: 14),
      headlineLarge: TextStyle(color: textColorDark, fontSize: 26, fontWeight: FontWeight.bold),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: whiteColor, backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    ), colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: primaryColor,
      onPrimary: backgroundColorDark,
      secondary: accentColor,
      onSecondary: backgroundColorDark,
      error: Colors.redAccent,
      onError: backgroundColorDark,
      surface: cardColorDark,
      onSurface: textColorDark,
    ).copyWith(surface: backgroundColorDark),
  );
}

extension ColorExtension on Color {
  String toHex({bool leadingHashSign = true, bool includeAlpha = false}) {
    String hex = includeAlpha
        ? alpha.toRadixString(16).padLeft(2, '0')
        : '';
    hex += '${red.toRadixString(16).padLeft(2, '0')}'
        '${green.toRadixString(16).padLeft(2, '0')}'
        '${blue.toRadixString(16).padLeft(2, '0')}';

    return '${leadingHashSign ? '#' : ''}$hex';
  }
}
