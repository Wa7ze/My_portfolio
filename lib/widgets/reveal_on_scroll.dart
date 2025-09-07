import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RevealOnScroll extends StatelessWidget {
  final Widget child;
  final Duration delay;
  const RevealOnScroll({super.key, required this.child, this.delay = Duration.zero});

  @override
  Widget build(BuildContext context) {
    final reduce = MediaQuery.maybeOf(context)?.disableAnimations ??
        WidgetsBinding.instance.platformDispatcher.accessibilityFeatures.disableAnimations;

    if (reduce) return child;

    return child
        .animate()
        .fadeIn(duration: 450.ms, delay: delay, curve: Curves.easeOutCubic)
        .slide(begin: const Offset(0, .08), curve: Curves.easeOutCubic);
  }
}
