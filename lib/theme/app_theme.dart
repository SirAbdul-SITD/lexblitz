// lib/theme/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // ── LexBlitz: Electric Neon Dark ─────────────────────────────────
  static const Color primary    = Color(0xFF6C63FF); // electric purple
  static const Color secondary  = Color(0xFF00D9FF); // cyan
  static const Color accent     = Color(0xFFFFD600); // gold
  static const Color purple     = Color(0xFF9B5DE5);
  static const Color pink       = Color(0xFFFF6B9D);
  static const Color green      = Color(0xFF00E5A0);
  static const Color blue       = Color(0xFF00D9FF);
  static const Color red        = Color(0xFFFF4D6D);

  static const Color background = Color(0xFF0F0F23);
  static const Color surface    = Color(0xFF1A1A3E);
  static const Color cardBg     = Color(0xFF1E1E42);
  static const Color textDark   = Color(0xFFFFFFFF);
  static const Color textMedium = Color(0xFFB0B0D0);
  static const Color textLight  = Color(0xFF606080);

  static const List<Color> tileColors = [
    Color(0xFF6C63FF), Color(0xFF00D9FF), Color(0xFFFF6B9D),
    Color(0xFF00E5A0), Color(0xFFFFD600), Color(0xFFFF4D6D),
    Color(0xFF9B5DE5), Color(0xFF00BFA5),
  ];

  static const LinearGradient bgGradient = LinearGradient(
    begin: Alignment.topLeft, end: Alignment.bottomRight,
    colors: [Color(0xFF0F0F23), Color(0xFF1A1A3E)],
  );
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF8B80FF), Color(0xFF6C63FF)],
    begin: Alignment.topLeft, end: Alignment.bottomRight,
  );
  static const LinearGradient classicGradient = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF5A52E0)],
    begin: Alignment.topLeft, end: Alignment.bottomRight,
  );
  static const LinearGradient chainGradient = LinearGradient(
    colors: [Color(0xFF00D9FF), Color(0xFF0099CC)],
    begin: Alignment.topLeft, end: Alignment.bottomRight,
  );
  static const LinearGradient blitzGradient = LinearGradient(
    colors: [Color(0xFFFF4D6D), Color(0xFFFF6B9D)],
    begin: Alignment.topLeft, end: Alignment.bottomRight,
  );

  static List<BoxShadow> cardShadow = [
    BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 16, offset: const Offset(0,4)),
  ];
  static List<BoxShadow> tileShadow(Color c) => [
    BoxShadow(color: c.withOpacity(0.6), blurRadius: 10, offset: const Offset(0,4)),
  ];
  static List<BoxShadow> buttonShadow(Color c) => [
    BoxShadow(color: c.withOpacity(0.5), blurRadius: 14, offset: const Offset(0,6)),
  ];

  static TextStyle get displayLarge => const TextStyle(fontFamily:'Nunito',fontSize:48,fontWeight:FontWeight.w800,color:textDark);
  static TextStyle get displayMedium => const TextStyle(fontFamily:'Nunito',fontSize:36,fontWeight:FontWeight.w800,color:textDark);
  static TextStyle get titleLarge => const TextStyle(fontFamily:'Nunito',fontSize:28,fontWeight:FontWeight.w700,color:textDark);
  static TextStyle get titleMedium => const TextStyle(fontFamily:'Nunito',fontSize:22,fontWeight:FontWeight.w700,color:textDark);
  static TextStyle get bodyLarge => const TextStyle(fontFamily:'Nunito',fontSize:18,fontWeight:FontWeight.w600,color:textDark);
  static TextStyle get bodyMedium => const TextStyle(fontFamily:'Nunito',fontSize:16,color:textMedium);
  static TextStyle get labelLarge => const TextStyle(fontFamily:'Nunito',fontSize:14,fontWeight:FontWeight.w700,color:textDark);

  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: primary, brightness: Brightness.dark),
    scaffoldBackgroundColor: background,
    fontFamily: 'Nunito',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent, elevation: 0, centerTitle: true,
      titleTextStyle: TextStyle(fontFamily:'Nunito',fontSize:24,fontWeight:FontWeight.w800,color:textDark),
    ),
  );
}
