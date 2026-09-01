import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_state.dart';
import '../core/planet_theme.dart';

/// A quiet, ever-so-slowly drifting made-up solar system that sits behind
/// every page: a sun (a black hole in dark mode) and four invented planets,
/// one permanently assigned to each page. The planets and sun don't move
/// relative to each other — instead, switching pages pans/rotates the
/// "camera" around the fixed configuration, so the active page's planet
/// swings into view while everything else (including the sun) drifts to
/// new apparent positions as a side effect, the same way a fixed star
/// field looks different depending on which way you're facing.
class CosmicBackground extends StatefulWidget {
  final String currentPage;
  const CosmicBackground({super.key, required this.currentPage});

  @override
  State<CosmicBackground> createState() => _CosmicBackgroundState();
}

// Focus angle: where the active page's planet lands on screen once the
// camera settles (radians; 0 = due "east"/right in canvas terms).
const _focusAngle = -0.35;

class _CosmicBackgroundState extends State<CosmicBackground> with TickerProviderStateMixin {
  late final AnimationController _idleController;
  late final AnimationController _sunController; // 0 = black hole, 1 = sun
  late final AnimationController _cameraController;
  double _cameraStart = 0;
  double _cameraDelta = 0;
  bool? _lastIsDark;
  String? _lastPage;

  late final List<String> _planetKeys;
  late final List<Offset> _stars;
  late final List<double> _starPhase;

  @override
  void initState() {
    super.initState();
    _idleController = AnimationController(vsync: this, duration: const Duration(minutes: 6))..repeat();
    _sunController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    _cameraController = AnimationController(vsync: this, duration: const Duration(milliseconds: 850));
    _planetKeys = kPlanetAngles.keys.toList();
    _cameraStart = _targetCameraAngle(widget.currentPage);

    final rnd = Random(7);
    _stars = List.generate(90, (_) => Offset(rnd.nextDouble(), rnd.nextDouble()));
    _starPhase = List.generate(90, (_) => rnd.nextDouble() * 2 * pi);
  }

  double _targetCameraAngle(String page) {
    final worldAngle = kPlanetAngles[page] ?? kPlanetAngles['home']!;
    return _focusAngle - worldAngle;
  }

  double _shortestDelta(double from, double to) {
    var delta = (to - from) % (2 * pi);
    if (delta > pi) delta -= 2 * pi;
    if (delta < -pi) delta += 2 * pi;
    return delta;
  }

  double get _currentCameraAngle =>
      _cameraStart + _cameraDelta * Curves.easeInOutCubic.transform(_cameraController.value.clamp(0.0, 1.0));

  @override
  void dispose() {
    _idleController.dispose();
    _sunController.dispose();
    _cameraController.dispose();
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

    if (_lastPage != widget.currentPage) {
      final target = _targetCameraAngle(widget.currentPage);
      if (_lastPage == null) {
        _cameraStart = target;
        _cameraDelta = 0;
      } else {
        final from = _currentCameraAngle;
        _cameraStart = from;
        _cameraDelta = _shortestDelta(from, target);
        _cameraController.forward(from: 0);
      }
      _lastPage = widget.currentPage;
    }

    return IgnorePointer(
      child: ClipRect(
        child: AnimatedBuilder(
          animation: Listenable.merge([_idleController, _sunController, _cameraController]),
          builder: (context, _) {
            return CustomPaint(
              painter: _CosmicPainter(
                idleT: _idleController.value,
                sunT: _sunController.value,
                cameraAngle: _currentCameraAngle,
                planetKeys: _planetKeys,
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

class _CosmicPainter extends CustomPainter {
  final double idleT;
  final double sunT;
  final double cameraAngle;
  final List<String> planetKeys;
  final List<Offset> stars;
  final List<double> starPhase;

  _CosmicPainter({
    required this.idleT,
    required this.sunT,
    required this.cameraAngle,
    required this.planetKeys,
    required this.stars,
    required this.starPhase,
  });

  static const _sunWorldAngle = 5.9;
  static const _sunRadiusFrac = 0.10;

  static const _radiusFrac = <String, double>{
    'home': 0.30,
    'about': 0.42,
    'work': 0.24,
    'contact': 0.36,
  };
  static const _planetSize = <String, double>{
    'home': 16,
    'about': 20,
    'work': 14,
    'contact': 18,
  };

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final pivot = Offset(size.width * 0.66, size.height * 0.34);
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

    _paintStardust(canvas, size);

    final purpleHaze = Paint()
      ..shader = RadialGradient(colors: [
        const Color(0xFF4B2E83).withOpacity(0.09),
        Colors.transparent,
      ]).createShader(Rect.fromCircle(center: Offset(size.width * 0.12, size.height * 0.82), radius: maxR * 0.5));
    canvas.drawRect(rect, purpleHaze);

    final orangeHaze = Paint()
      ..shader = RadialGradient(colors: [
        const Color(0xFFB3672E).withOpacity(0.07),
        Colors.transparent,
      ]).createShader(Rect.fromCircle(center: Offset(size.width * 0.9, size.height * 0.86), radius: maxR * 0.4));
    canvas.drawRect(rect, orangeHaze);

    // Sun/black hole drawn first so planets can pass in front of it.
    final sunPos = _project(pivot, maxR, _sunWorldAngle, _sunRadiusFrac, idlePhase: -1);
    _paintSunOrBlackHole(canvas, sunPos, maxR * _sunRadiusFrac);

    for (final key in planetKeys) {
      final worldAngle = kPlanetAngles[key]!;
      final theme = kPlanetThemes[key]!;
      final radiusFrac = _radiusFrac[key]!;
      final planetSize = _planetSize[key]!;
      final pos = _project(pivot, maxR, worldAngle, radiusFrac, idlePhase: worldAngle);

      if (theme.hasRing) {
        canvas.save();
        canvas.translate(pos.dx, pos.dy);
        canvas.rotate(0.45);
        final ringPaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.4
          ..color = theme.color.withOpacity(0.22);
        canvas.drawOval(Rect.fromCenter(center: Offset.zero, width: planetSize * 2.6, height: planetSize * 0.85), ringPaint);
        canvas.restore();
      }

      final planetPaint = Paint()
        ..shader = RadialGradient(colors: [
          theme.color.withOpacity(0.42),
          theme.color.withOpacity(0.06),
        ]).createShader(Rect.fromCircle(center: pos, radius: planetSize));
      canvas.drawCircle(pos, planetSize, planetPaint);
    }
  }

  Offset _project(Offset pivot, double maxR, double worldAngle, double radiusFrac, {required double idlePhase}) {
    final wobble = sin(idleT * 2 * pi + idlePhase) * 0.035;
    final angle = worldAngle + cameraAngle + wobble;
    final radius = maxR * radiusFrac;
    final shear = radius * 0.16;
    return pivot + Offset(cos(angle) * radius - sin(angle) * shear, sin(angle) * radius * 0.55);
  }

  void _paintStardust(Canvas canvas, Size size) {
    final starPaint = Paint();
    for (var i = 0; i < stars.length; i++) {
      final tw = (sin(idleT * 2 * pi * 3 + starPhase[i]) + 1) / 2;
      starPaint.color = Colors.white.withOpacity((0.05 + tw * 0.10) * (1 - sunT * 0.6));
      canvas.drawCircle(Offset(stars[i].dx * size.width, stars[i].dy * size.height), 0.8 + tw, starPaint);
    }
  }

  void _paintSunOrBlackHole(Canvas canvas, Offset center, double radius) {
    final coronaRadius = radius * 1.6;
    // Accretion-disk orange stays present even in black-hole mode — real
    // accretion disks glow hot, so this is where the site's "hint of
    // orange" lives when dark mode is active.
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.26
      ..shader = SweepGradient(colors: [
        Color.lerp(const Color(0xFFB3672E), const Color(0xFFFFC876), sunT)!.withOpacity(0.55),
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
          Color.lerp(const Color(0xFF120A08), const Color(0xFFFFB258), sunT * sunT)!.withOpacity(0.85),
          Colors.transparent,
        ],
        stops: const [0.0, 0.55, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: coreRadius));
    canvas.drawCircle(center, coreRadius, corePaint);
  }

  @override
  bool shouldRepaint(covariant _CosmicPainter oldDelegate) =>
      oldDelegate.idleT != idleT || oldDelegate.sunT != sunT || oldDelegate.cameraAngle != cameraAngle;
}
