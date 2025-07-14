import 'package:flutter/material.dart';

class AppTheme {
  // Renk paleti
  static const Color primaryBlue = Color(0xFF1A5CFF);
  static const Color backgroundGray = Color(0xFFF2F5F9);
  static const Color textDark = Color(0xFF333333);
  static const Color textMedium = Color(0xFF666666);
  static const Color textLight = Color(0xFFFFFFFF);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryBlue,
    scaffoldBackgroundColor: backgroundGray,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryBlue,
      foregroundColor: textLight,
      titleTextStyle: TextStyle(
        color: textLight,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: textLight),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textDark),
      bodyMedium: TextStyle(color: textMedium),
      bodySmall: TextStyle(color: textMedium),
    ),
    cardColor: Colors.white,
    hintColor: textMedium,
    dividerColor: Color(0xFFDDDDDD),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryBlue,
      unselectedItemColor: textMedium,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryBlue,
    scaffoldBackgroundColor: Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryBlue,
      foregroundColor: textLight,
      titleTextStyle: TextStyle(
        color: textLight,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: textLight),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textLight),
      bodyMedium: TextStyle(color: textLight),
      bodySmall: TextStyle(color: textLight),
    ),
    cardColor: Color(0xFF1E1E1E),
    hintColor: textMedium,
    dividerColor: Color(0xFF444444),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E1E1E),
      selectedItemColor: primaryBlue,
      unselectedItemColor: textMedium,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
    ),
  );
}
