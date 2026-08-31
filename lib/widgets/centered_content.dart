import 'package:flutter/material.dart';

/// Constrains content to a comfortable reading width and centers it,
/// so the page's own background shows on either side instead of content
/// stretching edge-to-edge on wide screens.
class CenteredContent extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const CenteredContent({super.key, required this.child, this.maxWidth = 1080});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
