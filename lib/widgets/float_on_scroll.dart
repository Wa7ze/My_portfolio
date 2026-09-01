import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// Wraps [child] so it drifts vertically as the page scrolls, based on how
/// far it sits from the viewport's vertical center — like it's floating in
/// the cosmic background rather than moving in lockstep with the scroll.
///
/// [weight] (0..1) gives each widget its own sense of mass: heavy (near 1)
/// elements lag behind and settle slowly, like something large drifting
/// underwater; light (near 0) elements are quick and twitchy. The offset is
/// always clamped to exactly [maxOffset].
///
/// [reserveSpace] controls how the "never touch a neighbor" guarantee is
/// enforced: when true (the default, safe for free-flowing Column/ListView
/// content) an invisible buffer equal to [maxOffset] is reserved around the
/// child so it can never paint outside its own slot. Fixed-height grid
/// cells can't safely donate extra space without squeezing their content,
/// so pass false there instead and keep [maxOffset] under half the grid's
/// own spacing — the gap between cells absorbs the movement instead.
class FloatOnScroll extends StatefulWidget {
  final Widget child;
  final double intensity;
  final double maxOffset;
  final double weight;
  final bool reserveSpace;

  const FloatOnScroll({
    super.key,
    required this.child,
    this.intensity = 0.09,
    this.maxOffset = 20,
    this.weight = 0.5,
    this.reserveSpace = true,
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
    final next = (-centerDelta * widget.intensity).clamp(-widget.maxOffset, widget.maxOffset);
    if ((next - _target).abs() < 0.4) return;
    _target = next;

    // Heavier widgets get a softer, slower spring (more lag, more overshoot);
    // lighter widgets snap quickly with little overshoot.
    final w = widget.weight.clamp(0.0, 1.0);
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
    // Clamp defensively in case a spring overshoot nudges slightly past
    // maxOffset — the collision guarantee below depends on this holding.
    final offset = _controller.value.clamp(-widget.maxOffset, widget.maxOffset);
    final translated = Transform.translate(
      key: _key,
      offset: Offset(0, offset),
      child: widget.child,
    );
    if (!widget.reserveSpace) return translated;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.maxOffset),
      child: translated,
    );
  }
}
