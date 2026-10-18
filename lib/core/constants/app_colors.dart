import 'package:flutter/material.dart';

class AppColors {
  // Primary Emerald & Mint Palette
  static const Color emeraldPrimary = Color(0xFF059669);
  static const Color emeraldLight = Color(0xFF10B981);
  static const Color mintAccent = Color(0xFF34D399);
  static const Color mintHighlight = Color(0xFF6EE7B7);
  static const Color forestDark = Color(0xFF064E3B);
  static const Color deepForest = Color(0xFF022C22);

  // Background & Surface
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFFFFFFF);
  
  // Dark accents & Slate
  static const Color textDark = Color(0xFF0F172A);
  static const Color textMuted = Color(0xFF64748B);
  static const Color textLight = Color(0xFF94A3B8);
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color chipBackground = Color(0xFFF1F5F9);

  // Status colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color gold = Color(0xFFFBBF24);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF059669), Color(0xFF10B981), Color(0xFF34D399)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroCardGradient = LinearGradient(
    colors: [Color(0xFF064E3B), Color(0xFF047857), Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFFBBF24)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient streakCardGradient = LinearGradient(
    colors: [Color(0xFF065F46), Color(0xFF047857)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient doneHabitGradient = LinearGradient(
    colors: [Color(0xFFECFDF5), Color(0xFFD1FAE5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
