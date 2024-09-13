import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
  primaryColor: const Color(0xFF228B22), // Soft Beige
  scaffoldBackgroundColor: const Color(0xFFF5F5DC),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFF333333)), // Dark Gray
    bodyLarge: TextStyle(color: Color(0xFF333333)),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFF228B22), // Forest Green
    textTheme: ButtonTextTheme.primary,
  ),
  iconTheme: const IconThemeData(
    color: Color(0xFF9ACD32), // Leaf Green
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: const Color(0xFFFF4500))
      .copyWith(surface: const Color(0xFFF5F5DC)),
);
