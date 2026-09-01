import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_state.dart';
import '../core/strings/app_strings.dart';
import 'cosmic_background.dart';
import 'left_sidebar.dart';

/// Persistent app-root chrome: the animated cosmic background, the
/// detached sidebar, its hamburger toggle, and the tap-outside-to-close
/// hit area. Lives above the router (wrapping its routed content) so none
/// of this state — especially the cosmic background's camera animation —
/// is ever destroyed and recreated by navigation, which is what caused it
/// to silently jump instead of animate.
class AppChrome extends StatelessWidget {
  final Widget child;
  const AppChrome({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final sidebarController = context.watch<SidebarController>();
    final currentPage = context.watch<CurrentPageController>().page;
    final isOpen = sidebarController.isOpen;

    return LayoutBuilder(
      builder: (context, constraints) {
        final sidebarWidth = (constraints.maxWidth * 0.85).clamp(0.0, 300.0).toDouble();
        return Stack(
          children: [
            Positioned.fill(child: CosmicBackground(currentPage: currentPage)),
            Positioned.fill(child: child),
            // Invisible tap-outside-to-close area — no dimming, the rest
            // of the page stays exactly as bright with the sidebar open.
            Positioned.fill(
              child: IgnorePointer(
                ignoring: !isOpen,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: sidebarController.close,
                ),
              ),
            ),
            _AnimatedSidebar(
              isOpen: isOpen,
              width: sidebarWidth,
              child: LeftSidebar(currentPage: currentPage),
            ),
            PositionedDirectional(
              top: 16,
              start: 16,
              child: _MenuButton(isOpen: isOpen, onTap: sidebarController.toggle),
            ),
          ],
        );
      },
    );
  }
}

/// Explicit fade+slide transition for the sidebar panel (rather than an
/// implicit AnimatedPositioned) so open/close reliably reads as a motion,
/// not a snap — slides in from the leading edge while fading in, and the
/// reverse on close.
class _AnimatedSidebar extends StatefulWidget {
  final bool isOpen;
  final double width;
  final Widget child;

  const _AnimatedSidebar({required this.isOpen, required this.width, required this.child});

  @override
  State<_AnimatedSidebar> createState() => _AnimatedSidebarState();
}

class _AnimatedSidebarState extends State<_AnimatedSidebar> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _slide;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
      reverseDuration: const Duration(milliseconds: 420),
      value: widget.isOpen ? 1 : 0,
    );
    _slide = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic, reverseCurve: Curves.easeInCubic);
    _fade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.15, 1.0, curve: Curves.easeOut),
      reverseCurve: const Interval(0.0, 0.85, curve: Curves.easeIn),
    );
  }

  @override
  void didUpdateWidget(covariant _AnimatedSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen != oldWidget.isOpen) {
      widget.isOpen ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final closedStart = -(widget.width + 40);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final start = closedStart + (16 - closedStart) * _slide.value;
        return PositionedDirectional(
          top: 16,
          bottom: 16,
          start: start,
          width: widget.width,
          child: Opacity(opacity: _fade.value, child: child),
        );
      },
      child: widget.child,
    );
  }
}

class _MenuButton extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onTap;
  const _MenuButton({required this.isOpen, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.strings;
    return Material(
      color: theme.cardColor,
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.dividerColor),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              isOpen ? Icons.close : Icons.menu,
              key: ValueKey(isOpen),
              color: theme.colorScheme.onSurface,
              semanticLabel: isOpen ? strings.closeMenu : strings.openMenu,
            ),
          ),
        ),
      ),
    );
  }
}
