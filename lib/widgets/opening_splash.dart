import 'dart:math';
import 'package:flutter/material.dart';

/// A quick, watery "code swirling into place" intro that plays once per app
/// load (a browser refresh remounts the widget tree, so it naturally
/// replays) and fades away to reveal the site underneath.
class OpeningSplash extends StatefulWidget {
  final Widget child;
  const OpeningSplash({super.key, required this.child});

  @override
  State<OpeningSplash> createState() => _OpeningSplashState();
}

class _OpeningSplashState extends State<OpeningSplash> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _visible = true;

  static const _glyphs = ['{', '}', '<', '>', ';', '=', '(', ')', '/', '*', '#', '[', ']', '+', '-', '_', '.', ':', '=>', '&&'];
  static const _snippet = 'const you = build();';

  @override
  void initState() {
    super.initState();
    final reduceMotion = WidgetsBinding.instance.platformDispatcher.accessibilityFeatures.disableAnimations;
    _controller = AnimationController(
      vsync: this,
      duration: reduceMotion ? Duration.zero : const Duration(milliseconds: 2400),
    );
    if (reduceMotion) {
      _visible = false;
    } else {
      _controller.forward();
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed && mounted) {
          setState(() => _visible = false);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_visible)
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  final t = _controller.value;
                  final spiralT = Curves.easeOutCubic.transform((t / 0.68).clamp(0.0, 1.0).toDouble());
                  const holdEnd = 0.82;
                  final fadeT = t <= holdEnd ? 0.0 : ((t - holdEnd) / (1 - holdEnd)).clamp(0.0, 1.0).toDouble();
                  final opacity = 1.0 - Curves.easeIn.transform(fadeT);
                  return Opacity(
                    opacity: opacity,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        gradient: RadialGradient(
                          radius: 1.1,
                          colors: [Color(0xFF16233A), Color(0xFF060911)],
                        ),
                      ),
                      child: SizedBox.expand(
                        child: CustomPaint(
                          painter: _SpiralPainter(progress: spiralT, time: t * 7.5),
                          child: Center(
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: _TypedSnippet(progress: (t / 0.55).clamp(0.0, 1.0).toDouble()),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}

class _TypedSnippet extends StatelessWidget {
  final double progress;
  const _TypedSnippet({required this.progress});

  @override
  Widget build(BuildContext context) {
    const text = _OpeningSplashState._snippet;
    final count = (text.length * progress).round().clamp(0, text.length).toInt();
    final shown = text.substring(0, count);
    return Text(
      '$shown${count < text.length ? '▏' : ''}',
      style: const TextStyle(
        color: Color(0xFF9FD3FF),
        fontFamily: 'monospace',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }
}

class _SpiralPainter extends CustomPainter {
  final double progress;
  final double time;
  static const _n = 26;

  _SpiralPainter({required this.progress, required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final maxRadius = size.shortestSide * 0.42;
    const goldenAngle = 2.399963;

    for (int i = 0; i < _n; i++) {
      final delay = i / _n * 0.55;
      final local = ((progress - delay) / (1 - delay)).clamp(0.0, 1.0).toDouble();
      if (local <= 0) continue;
      final eased = Curves.easeOutCubic.transform(local);
      final baseAngle = i * goldenAngle;
      final angle = baseAngle + progress * 3.4;
      final spacing = sqrt(i / _n);
      final jitter = sin(time + i) * 6.0 * eased;
      final radius = eased * maxRadius * spacing + jitter;
      final pos = center + Offset(cos(angle), sin(angle)) * radius;
      final char = _OpeningSplashState._glyphs[i % _OpeningSplashState._glyphs.length];
      final tp = TextPainter(
        text: TextSpan(
          text: char,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7 * eased),
            fontSize: 14 + (i % 4) * 2,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, pos - Offset(tp.width / 2, tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant _SpiralPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.time != time;
}
