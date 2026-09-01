import 'package:flutter/material.dart';

/// One invented planet per main page, shared between the cosmic background
/// and the sidebar nav so a page's colour/icon always matches its planet.
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

/// Fixed world angle (radians) for each planet — deliberately uneven
/// spacing so the layout reads as an invented system, not a compass.
const kPlanetAngles = <String, double>{
  'home': 0.25,
  'about': 1.65,
  'work': 3.35,
  'contact': 4.95,
};
