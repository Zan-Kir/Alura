import 'package:flutter/material.dart';

final myTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF2F80ED),
    dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
  ),
  appBarTheme: const AppBarTheme(
      color: Color(0xFF2F80ED), foregroundColor: Colors.white),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2F80ED),
          foregroundColor: Colors.white)),
  useMaterial3: true,
);