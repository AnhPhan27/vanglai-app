import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(
    0xFFF58220,
  ); // Orange - Icons, Active Tab, Highlights
  static const Color primaryDark = Color(0xFFE56F0F);
  static const Color primaryLight = Color(0xFFFFA85C);

  // Accent Colors
  static const Color accent = Color(
    0xFF1DB984,
  ); // Green - Post Match Button, Main Actions
  static const Color accentDark = Color(0xFF15A170);
  static const Color accentLight = Color(0xFF3DD9A7);

  // Background Colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundLight = Color(0xFFF9FAFB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF9FAFB);

  // Tab Colors
  static const Color tabUnselected = Color(0xFFE5E7EB);
  static const Color tabSelected = primary;

  // Text Colors
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(
    0xFF6B7280,
  ); // Neutral Gray - Descriptions
  static const Color textPlaceholder = Color(
    0xFF9CA3AF,
  ); // Light Gray - Placeholders
  static const Color textBlack = Color(0xFF000000); // Pure Black
  static const Color textWhite = Color(0xFFFFFFFF); // Pure White

  // Border & Divider Colors
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderLight = Color(0xFFF3F4F6);
  static const Color borderDashed = Color(
    0xFFD1D5DB,
  ); // Dashed Border - Upload Frame
  static const Color divider = Color(0xFFE5E7EB);

  // Status Colors
  static const Color success = Color(0xFF1DB984);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);

  // Match Status Colors (Confirmed/Open)
  static const Color statusConfirmedBg = Color(0xFFD1FAE5); // Light green
  static const Color statusConfirmedText = Color(0xFF059669); // Dark green

  // Match Status Colors (Pending)
  static const Color statusPendingBg = Color(0xFFFFEDD5); // Light orange
  static const Color statusPendingText = Color(0xFFD97706); // Dark orange

  // Match Status Colors (Full)
  static const Color statusFullBg = Color(0xFFFEF3C7); // Light yellow
  static const Color statusFullText = Color(0xFFD97706); // Dark orange

  // Match Status Colors (Cancelled)
  static const Color statusCancelledBg = Color(0xFFF3F4F6); // Light gray
  static const Color statusCancelledText = Color(0xFF6B7280); // Medium gray

  // Skill Level Colors (Intermediate)
  static const Color skillIntermediateBg = Color(0xFFF5F3FF); // Light purple
  static const Color skillIntermediateText = Color(0xFF7C3AED); // Purple

  // Skill Level Colors (Competitive)
  static const Color skillCompetitiveBg = Color(0xFFFFF7ED); // Light orange
  static const Color skillCompetitiveText = Color(0xFFEA580C); // Orange-red

  // Icon Background Colors
  static const Color iconBgCalendar = Color(0xFFFFEDD5); // Light orange
  static const Color iconBgLocation = Color(0xFFD1FAE5); // Light green

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, accentDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Common opacity variations (RGBA format to avoid .withOpacity)
  static const Color white10 = Color.fromRGBO(255, 255, 255, 0.1); // 10%
  static const Color white30 = Color.fromRGBO(255, 255, 255, 0.3); // 30%
  static const Color white50 = Color.fromRGBO(255, 255, 255, 0.5); // 50%
  static const Color white70 = Color.fromRGBO(255, 255, 255, 0.7); // 70%
  static const Color white90 = Color.fromRGBO(255, 255, 255, 0.9); // 90%

  static const Color black10 = Color.fromRGBO(0, 0, 0, 0.1); // 10%
  static const Color black26 = Color.fromRGBO(0, 0, 0, 0.26); // 26%
  static const Color black30 = Color.fromRGBO(0, 0, 0, 0.3); // 30%
  static const Color black40 = Color.fromRGBO(0, 0, 0, 0.4); // 40%
  static const Color black50 = Color.fromRGBO(0, 0, 0, 0.5); // 50%
}
