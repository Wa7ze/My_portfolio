import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_state.dart';

/// A quiet, ever-so-slowly drifting made-up solar system that sits behind
/// every page: a handful of invented planets orbiting a centerpiece that is
/// a warm sun in light mode and a collapsed black hole in dark mode, with a
/// faint blue/purple stardust haze. Deliberately low-contrast — it reads as
/// texture, not a focal point.
class CosmicBackground extends StatefulWidget {
  const CosmicBackground({super.key});

  @override
  State<CosmicBackground> createState() => _CosmicBackgroundState();
}

class _CosmicBackgroundState extends State<CosmicBackground> with TickerProviderStateMixin {
  late final AnimationController _orbitController;
  late final AnimationController _sunController; // 0 = black hole, 1 = sun
  bool? _lastIsDark;

  late final List<_PlanetSpec> _planets;
  late final List<Offset> _stars;
  late final List<double> _starPhase;

  @override
  void initState() {
    super.initState();
    _orbitController = AnimationController(vsync: this, duration: const Duration(minutes: 6))..repeat();
    _sunController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));

    final rnd = Random(7);
    const palette = [
      Color(0xFF6B9BD2),
      Color(0xFF7FB3FF),
      Color(0xFF8B6FD6),
      Color(0xFFB794F6),
      Color(0xFF5B4B8A),
      Color(0xFF4A7BA7),
    ];
    _planets = List.generate(6, (i) {
      return _PlanetSpec(
        radiusFromCenter: 0.16 + i * 0.115 + rnd.nextDouble() * 0.03,
        size: 8.0 + rnd.nextDouble() * 22,
        speed: 0.35 + rnd.nextDouble() * 0.45,
        phase: rnd.nextDouble() * 2 * pi,
        color: palette[i % palette.length],
        hasRing: i.isOdd,
      );
    });

    _stars = List.generate(90, (_) => Offset(rnd.nextDouble(), rnd.nextDouble()));
    _starPhase = List.generate(90, (_) => rnd.nextDouble() * 2 * pi);
  }

  @override
  void dispose() {
    _orbitController.dispose();
    _sunController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeController>().isDark;
    if (_lastIsDark == null) {
      _sunController.value = isDark ? 0.0 : 1.0;
    } else if (_lastIsDark != isDark) {
      _sunController.animateTo(isDark ? 0.0 : 1.0, curve: Curves.easeInOutCubic);
    }
    _lastIsDark = isDark;

    return IgnorePointer(
      child: ClipRect(
        child: AnimatedBuilder(
          animation: Listenable.merge([_orbitController, _sunController]),
          builder: (context, _) {
            return CustomPaint(
              painter: _CosmicPainter(
                orbitT: _orbitController.value,
                sunT: _sunController.value,
                planets: _planets,
                stars: _stars,
                starPhase: _starPhase,
              ),
              size: Size.infinite,
            );
          },
        ),
      ),
    );
  }
}

class _PlanetSpec {
  final double radiusFromCenter;
  final double size;
  final double speed;
  final double phase;
  final Color color;
  final bool hasRing;

  _PlanetSpec({
    required this.radiusFromCenter,
    required this.size,
    required this.speed,
    required this.phase,
    required this.color,
    required this.hasRing,
  });
}

class _CosmicPainter extends CustomPainter {
  final double orbitT;
  final double sunT;
  final List<_PlanetSpec> planets;
  final List<Offset> stars;
  final List<double> starPhase;

  _CosmicPainter({
    required this.orbitT,
    required this.sunT,
    required this.planets,
    required this.stars,
    required this.starPhase,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = Offset(size.width * 0.78, size.height * 0.2);
    final maxR = size.shortestSide;

    final bg = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.5, -0.6),
        radius: 1.5,
        colors: [
          Color.lerp(const Color(0xFF17102B), const Color(0xFFF3F0FF), sunT)!,
          Color.lerp(const Color(0xFF0B0714), const Color(0xFFEAF2FF), sunT)!,
        ],
      ).createShader(rect);
    canvas.drawRect(rect, bg);

    final starPaint = Paint();
    for (var i = 0; i < stars.length; i++) {
      final tw = (sin(orbitT * 2 * pi * 3 + starPhase[i]) + 1) / 2;
      final baseOpacity = 0.05 + tw * 0.10;
      starPaint.color = Colors.white.withOpacity(baseOpacity * (1 - sunT * 0.6));
      canvas.drawCircle(Offset(stars[i].dx * size.width, stars[i].dy * size.height), 0.8 + tw, starPaint);
    }

    final haze = Paint()
      ..shader = RadialGradient(colors: [
        const Color(0xFF4B2E83).withOpacity(0.09),
        Colors.transparent,
      ]).createShader(Rect.fromCircle(center: Offset(size.width * 0.14, size.height * 0.8), radius: maxR * 0.55));
    canvas.drawRect(rect, haze);

    for (final p in planets) {
      final angle = p.phase + orbitT * 2 * pi * p.speed;
      final orbitRadius = maxR * p.radiusFromCenter;
      final pos = center + Offset(cos(angle) * orbitRadius, sin(angle) * orbitRadius * 0.55);
      if (p.hasRing) {
        canvas.save();
        canvas.translate(pos.dx, pos.dy);
        canvas.rotate(0.45);
        final ringPaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.3
          ..color = p.color.withOpacity(0.16);
        canvas.drawOval(Rect.fromCenter(center: Offset.zero, width: p.size * 2.6, height: p.size * 0.85), ringPaint);
        canvas.restore();
      }
      final planetPaint = Paint()
        ..shader = RadialGradient(colors: [
          p.color.withOpacity(0.30),
          p.color.withOpacity(0.04),
        ]).createShader(Rect.fromCircle(center: pos, radius: p.size));
      canvas.drawCircle(pos, p.size, planetPaint);
    }

    _paintSunOrBlackHole(canvas, center, maxR * 0.10);
  }

  void _paintSunOrBlackHole(Canvas canvas, Offset center, double radius) {
    final coronaRadius = radius * 1.6;
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.26
      ..shader = SweepGradient(colors: [
        Color.lerp(const Color(0xFF6B9BD2), const Color(0xFFFFC876), sunT)!.withOpacity(0.5),
        Colors.transparent,
        Color.lerp(const Color(0xFF8B6FD6), const Color(0xFFFF9A56), sunT)!.withOpacity(0.45),
        Colors.transparent,
      ]).createShader(Rect.fromCircle(center: center, radius: coronaRadius));
    canvas.drawCircle(center, coronaRadius, ringPaint);

    final coreRadius = radius * (1 + sunT * 0.6);
    final corePaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Color.lerp(const Color(0xFF000000), const Color(0xFFFFF3D6), sunT * sunT)!,
          Color.lerp(const Color(0xFF0A0A12), const Color(0xFFFFB258), sunT * sunT)!.withOpacity(0.85),
          Colors.transparent,
        ],
        stops: const [0.0, 0.55, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: coreRadius));
    canvas.drawCircle(center, coreRadius, corePaint);
  }

  @override
  bool shouldRepaint(covariant _CosmicPainter oldDelegate) => oldDelegate.orbitT != orbitT || oldDelegate.sunT != sunT;
}
