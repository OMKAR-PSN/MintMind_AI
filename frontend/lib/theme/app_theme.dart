import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0B0F14),
    primaryColor: const Color(0xFFF97316), // Orange
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFF97316),
      secondary: Color(0xFF22C55E), // Green
    ),
    cardColor: const Color(0xFF111827),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
    useMaterial3: true,
  );
}
