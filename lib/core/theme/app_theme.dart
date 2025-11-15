import 'package:flutter/material.dart';

class AppTheme {
  // Tema Claro
  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: true);

    final colorScheme = base.colorScheme.copyWith(
      primary: const Color(0xFF1B8E5A), // Verde primário
      secondary: const Color(0xFF49BF85), // Verde secundário
      onPrimary: Colors.white,
      onSecondary: Colors.black,
    );

    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFFF4F7F5),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: const Color(0xFF1A1A1A),
        displayColor: const Color(0xFF1A1A1A),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFF1B8E5A),
      ),

      // 🔹 CardTheme sem erro, usando copyWith
      cardTheme: base.cardTheme.copyWith(
        color: Colors.white,
        shadowColor: Colors.green.withOpacity(0.15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFF1B8E5A),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF1B8E5A),
          side: const BorderSide(
            color: Color(0xFF1B8E5A),
            width: 1.5,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: const Color(0xFFE0F2E9),
        selectedColor: const Color(0xFF1B8E5A),
        labelStyle: const TextStyle(
          color: Color(0x45FCFCFC),
          fontWeight: FontWeight.w500,
        ),
        secondaryLabelStyle: const TextStyle(
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: Color(0xFF1B8E5A),
            width: 1.5,
          ),
        ),
      ),
    );
  }

  // Tema Escuro
  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);

    final colorScheme = base.colorScheme.copyWith(
      primary: const Color(0xFF49BF85),
      secondary: const Color(0xFF1B8E5A),
      onPrimary: Colors.black,
    );

    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFF49BF85),
      ),

      // 🔹 CardTheme escuro, também com copyWith
      cardTheme: base.cardTheme.copyWith(
        color: const Color(0xFF1A1A1A),
        shadowColor: Colors.green.withOpacity(0.15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFF49BF85),
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A1A1A),
          foregroundColor: const Color(0xFF49BF85),
          side: const BorderSide(
            color: Color(0xFF49BF85),
            width: 1.5,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: const Color(0xFF1A1A1A),
        selectedColor: const Color(0xFF49BF85),
        labelStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        secondaryLabelStyle: const TextStyle(
          color: Colors.white30,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: Color(0xFF49BF85),
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
