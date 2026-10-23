import 'package:flutter/material.dart';

class AppColors {
  static const forest = Color(0xFF102F15);
  static const moss = Color(0xFF728C5A);
  static const cream = Color(0xFFEAF1B1);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);

  static List<BoxShadow> get softShadow => [
        BoxShadow(
          color: forest.withValues(alpha: 0.10),
          blurRadius: 24,
          offset: const Offset(0, 10),
        ),
        BoxShadow(
          color: forest.withValues(alpha: 0.05),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get navShadow => [
        BoxShadow(
          color: forest.withValues(alpha: 0.08),
          blurRadius: 20,
          offset: const Offset(0, -4),
        ),
      ];
}
