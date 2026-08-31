import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// Wraps [child] so it drifts vertically as the page scrolls, based on how
/// far it sits from the viewport's vertical center — like it's floating in
/// the cosmic background rather than moving in lockstep with the scroll.
///
/// [weight] (0..1) gives each widget its own sense of mass: heavy (near 1)
/// elements swing further and lag behind, settling slowly like something
/// large drifting underwater; light (near 0) elements are quick and twitchy.
/// The offset is bounded and self-corrects toward zero near the viewport
/// center, so nothing drifts away from its neighbors.
class FloatOnScroll extends StatefulWidget {
  final Widget child;
  final double intensity;
  final double maxOffset;
  final double weight;

  const FloatOnScroll({
    super.key,
    required this.child,
    this.intensity = 0.09,
    this.maxOffset = 20,
    this.weight = 0.5,
  });

  @override
  State<FloatOnScroll> createState() => _FloatOnScrollState();
}

class _FloatOnScrollState extends State<FloatOnScroll> with SingleTickerProviderStateMixin {
  final _key = GlobalKey();
  ScrollPosition? _position;
  late final AnimationController _controller;
  double _target = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(vsync: this)..addListener(() => setState(() {}));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newPosition = Scrollable.maybeOf(context)?.position;
    if (newPosition != _position) {
      _position?.removeListener(_handleScroll);
      _position = newPosition;
      _position?.addListener(_handleScroll);
      WidgetsBinding.instance.addPostFrameCallback((_) => _handleScroll());
    }
  }

  void _handleScroll() {
    if (!mounted) return;
    final box = _key.currentContext?.findRenderObject();
    if (box is! RenderBox || !box.attached) return;
    final viewportHeight = MediaQuery.sizeOf(context).height;
    final dy = box.localToGlobal(Offset.zero).dy;
    final centerDelta = (dy + box.size.height / 2) - viewportHeight / 2;
    final w = widget.weight.clamp(0.0, 1.0);
    final amplitude = widget.maxOffset * (0.7 + w * 0.6);
    final next = (-centerDelta * widget.intensity).clamp(-amplitude, amplitude);
    if ((next - _target).abs() < 0.4) return;
    _target = next;

    // Heavier widgets get a softer, slower spring (more lag, more overshoot);
    // lighter widgets snap quickly with little overshoot.
    final mass = 1.0 + w * 5;
    final stiffness = 70.0 - w * 30;
    final damping = 16.0 - w * 4;
    _controller.animateWith(
      SpringSimulation(SpringDescription(mass: mass, stiffness: stiffness, damping: damping), _controller.value, _target, 0),
    );
  }

  @override
  void dispose() {
    _position?.removeListener(_handleScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      key: _key,
      offset: Offset(0, _controller.value),
      child: widget.child,
    );
  }
}
