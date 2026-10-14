import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Aurora Palette (Unique Warm) ─────────────
  static const Color primary = Color(0xFFE85D4A);        // Coral Red
  static const Color primaryDark = Color(0xFFC44536);
  static const Color primaryLight = Color(0xFFFF8A7A);
  static const Color accent = Color(0xFFFFB84D);         // Warm Amber
  static const Color accent2 = Color(0xFF6C5CE7);        // Soft Indigo

  // ── Backgrounds (Warm Sand) ──────────────────
  static const Color background = Color(0xFFFAF6F2);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color card = Color(0xFFFFFFFF);
  static const Color cardSoft = Color(0xFFFFF9F5);

  // ── Status ───────────────────────────────────
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFFFB84D);
  static const Color error = Color(0xFFE85D4A);
  static const Color info = Color(0xFF3B82F6);

  // ── Priority ─────────────────────────────────
  static const Color priorityLow = Color(0xFF10B981);
  static const Color priorityMedium = Color(0xFFFFB84D);
  static const Color priorityHigh = Color(0xFFE85D4A);

  // ── Text ─────────────────────────────────────
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textHint = Color(0xFFA8A8A8);

  // ── Borders ──────────────────────────────────
  static const Color border = Color(0xFFEDE4DC);
  static const Color divider = Color(0xFFF5EFE9);

  // ── Unique Gradients ─────────────────────────
  static const LinearGradient coralGradient = LinearGradient(
    colors: [Color(0xFFE85D4A), Color(0xFFFF8A5C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient sunsetGradient = LinearGradient(
    colors: [Color(0xFFFFB84D), Color(0xFFE85D4A), Color(0xFF6C5CE7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient peachGradient = LinearGradient(
    colors: [Color(0xFFFFF0E8), Color(0xFFFFE4D6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}