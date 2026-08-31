import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kAccentColor = Color(0xFF6B9BD2);
const kAccentColorDark = Color(0xFF7FB3FF);

TextTheme _buildTextTheme(Color base) {
  return GoogleFonts.interTextTheme().apply(bodyColor: base, displayColor: base).copyWith(
        displayLarge: GoogleFonts.inter(fontSize: 57, fontWeight: FontWeight.w800, letterSpacing: -0.25, height: 1.12, color: base),
        displayMedium: GoogleFonts.inter(fontSize: 45, fontWeight: FontWeight.w800, letterSpacing: -0.25, height: 1.16, color: base),
        displaySmall: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.w800, letterSpacing: -0.25, height: 1.22, color: base),
        headlineLarge: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: -0.25, height: 1.25, color: base),
        headlineMedium: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: -0.25, height: 1.29, color: base),
        headlineSmall: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w600, letterSpacing: -0.25, height: 1.33, color: base),
        titleLarge: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w600, letterSpacing: -0.25, height: 1.27, color: base),
        titleMedium: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15, height: 1.50, color: base),
        titleSmall: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1, height: 1.43, color: base),
        bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5, height: 1.50, color: base),
        bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 1.43, color: base),
        bodySmall: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4, height: 1.33, color: base),
      );
}

ThemeData buildLightTheme() {
  final colorScheme = ColorScheme.fromSeed(seedColor: kAccentColor, brightness: Brightness.light);
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    textTheme: _buildTextTheme(const Color(0xFF14181F)),
    scaffoldBackgroundColor: const Color(0xFFF8FAFC),
    cardColor: Colors.white,
    dividerColor: Colors.black12,
    extensions: const [AppPalette.light],
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
  );
}

ThemeData buildDarkTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: kAccentColorDark,
    brightness: Brightness.dark,
  ).copyWith(surface: const Color(0xFF0B0F19));
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    textTheme: _buildTextTheme(const Color(0xFFEDEFF3)),
    scaffoldBackgroundColor: const Color(0xFF0B0F19),
    cardColor: const Color(0xFF141B2A),
    dividerColor: Colors.white12,
    extensions: const [AppPalette.dark],
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
  );
}

/// Extra colors that don't map cleanly onto [ColorScheme], kept theme-aware
/// so widgets never have to hardcode a light-only [Colors.grey]/[Colors.black].
class AppPalette extends ThemeExtension<AppPalette> {
  final Color cardBackground;
  final Color cardBorder;
  final Color mutedText;
  final Color skeletonBase;
  final Color skeletonHighlight;
  final List<Color> heroGradient;

  const AppPalette({
    required this.cardBackground,
    required this.cardBorder,
    required this.mutedText,
    required this.skeletonBase,
    required this.skeletonHighlight,
    required this.heroGradient,
  });

  static const light = AppPalette(
    cardBackground: Color(0xFFF9FAFB),
    cardBorder: Color(0x1A000000),
    mutedText: Color(0xFF6B7280),
    skeletonBase: Color(0xFFE5E7EB),
    skeletonHighlight: Color(0xFFF3F4F6),
    heroGradient: [
      Color(0xFFF0F8FF),
      Color(0xFFE6F3FF),
      Color(0xFFB3D9FF),
      Color(0xFF6B9BD2),
      Color(0xFF4A7BA7),
    ],
  );

  static const dark = AppPalette(
    cardBackground: Color(0xFF141B2A),
    cardBorder: Color(0x33FFFFFF),
    mutedText: Color(0xFF9AA5B4),
    skeletonBase: Color(0xFF1C2534),
    skeletonHighlight: Color(0xFF263148),
    heroGradient: [
      Color(0xFF0B0F19),
      Color(0xFF0D1526),
      Color(0xFF122038),
      Color(0xFF1B3A5C),
      Color(0xFF2C5B8A),
    ],
  );

  @override
  AppPalette copyWith({
    Color? cardBackground,
    Color? cardBorder,
    Color? mutedText,
    Color? skeletonBase,
    Color? skeletonHighlight,
    List<Color>? heroGradient,
  }) {
    return AppPalette(
      cardBackground: cardBackground ?? this.cardBackground,
      cardBorder: cardBorder ?? this.cardBorder,
      mutedText: mutedText ?? this.mutedText,
      skeletonBase: skeletonBase ?? this.skeletonBase,
      skeletonHighlight: skeletonHighlight ?? this.skeletonHighlight,
      heroGradient: heroGradient ?? this.heroGradient,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    return AppPalette(
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      cardBorder: Color.lerp(cardBorder, other.cardBorder, t)!,
      mutedText: Color.lerp(mutedText, other.mutedText, t)!,
      skeletonBase: Color.lerp(skeletonBase, other.skeletonBase, t)!,
      skeletonHighlight: Color.lerp(skeletonHighlight, other.skeletonHighlight, t)!,
      heroGradient: heroGradient,
    );
  }
}

extension AppPaletteX on BuildContext {
  AppPalette get palette => Theme.of(this).extension<AppPalette>()!;
}
