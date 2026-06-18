import 'package:flutter/material.dart';

class AppColors {
  // Main Surface Colors
  static const Color background = Color(0xFFFBF9F4);
  static const Color surface = Color(0xFFFBF9F4);
  static const Color surfaceVariant = Color(0xFFF5F3EE);
  static const Color surfaceContainerLow = Color(0xFFF5F3EE);

  // Brand & Accent Colors
  static const Color primary = Color(0xFFD67D61); // Terracotta
  static const Color secondary = Color(0xFF7E7D78);
  static const Color tertiary = Color(0xFF90A98D); // Sage/Wellness

  // Status & Interactive
  static const Color error = Color(0xFFBA1A1A);
  static const Color outline = Color(0xFF7E7D78);
  static const Color outlineVariant = Color(0xFFDBDAD5);

  // Text & Icons
  static const Color onSurface = Color(0xFF1E1B1A);
  static const Color onSurfaceVariant = Color(0xFF4C4643);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Task Categories (Specific to Today's Focus)
  static const Color wellnessCategory = Color(
    0xFFE8F3E5,
  ); // Soft Sage background
  static const Color workCategory = Color(0xFFF5F3EE); // Neutral surface
  static const Color personalCategory = Color(0xFFF5F3EE); // Neutral surface
  static const Color creativeTag = Color(0xFFF5F3EE);
}
