import 'package:flutter/material.dart';

/// One invented planet per real page, shared between the cosmic background
/// and the sidebar nav so a page's colour/icon always matches its planet.
/// 'about' isn't a page anymore (its content lives on Home) but its colour
/// stays defined here since the merged About content on Home still uses it
/// as a section accent.
class PlanetTheme {
  final Color color;
  final bool hasRing;
  final IconData icon;
  const PlanetTheme({required this.color, required this.hasRing, required this.icon});
}

const kPlanetThemes = <String, PlanetTheme>{
  'home': PlanetTheme(color: Color(0xFF7FB3FF), hasRing: false, icon: Icons.public),
  'about': PlanetTheme(color: Color(0xFFB794F6), hasRing: true, icon: Icons.brightness_2),
  'work': PlanetTheme(color: Color(0xFF5FD4C4), hasRing: false, icon: Icons.language),
  'contact': PlanetTheme(color: Color(0xFFFFA35C), hasRing: true, icon: Icons.blur_circular),
};

/// Fixed world angle (radians) for each *navigable page's* planet —
/// deliberately uneven spacing so the layout reads as an invented system,
/// not a compass. Only the 3 real pages orbit; 'about' has no planet of
/// its own since it's no longer a separate destination.
const kPlanetAngles = <String, double>{
  'home': 0.3,
  'work': 2.6,
  'contact': 4.4,
};
