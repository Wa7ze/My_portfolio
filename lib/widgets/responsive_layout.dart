import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_state.dart';

/// Wraps page content in a transparent Scaffold (the app-root [AppChrome]
/// paints the cosmic background and the sidebar behind/over it) and
/// reports which page is active to [CurrentPageController]. The chrome
/// deliberately lives outside the routed subtree so its animations —
/// especially the cosmic background's camera — survive navigation instead
/// of being torn down and rebuilt from scratch on every page change.
class ResponsiveLayout extends StatelessWidget {
  final Widget child;
  final String currentPage;

  const ResponsiveLayout({super.key, required this.child, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) context.read<CurrentPageController>().setPage(currentPage);
    });
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: child,
    );
  }
}
