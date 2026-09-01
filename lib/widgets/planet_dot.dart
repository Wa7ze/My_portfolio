import 'package:flutter/material.dart';

/// Small planet symbol used both in the sidebar nav and on any button that
/// jumps to a page, so the icon always matches that page's planet in the
/// cosmic background.
class PlanetDot extends StatelessWidget {
  final Color color;
  final bool hasRing;
  final double size;
  const PlanetDot({super.key, required this.color, required this.hasRing, this.size = 16});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _PlanetDotPainter(color: color, hasRing: hasRing)),
    );
  }
}

class _PlanetDotPainter extends CustomPainter {
  final Color color;
  final bool hasRing;
  _PlanetDotPainter({required this.color, required this.hasRing});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    if (hasRing) {
      final ringPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..color = color.withOpacity(0.7);
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(0.5);
      canvas.drawOval(Rect.fromCenter(center: Offset.zero, width: size.width * 1.15, height: size.height * 0.42), ringPaint);
      canvas.restore();
    }
    final corePaint = Paint()
      ..shader = RadialGradient(colors: [color, color.withOpacity(0.55)])
          .createShader(Rect.fromCircle(center: center, radius: size.width * 0.34));
    canvas.drawCircle(center, size.width * 0.34, corePaint);
  }

  @override
  bool shouldRepaint(covariant _PlanetDotPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.hasRing != hasRing;
}
