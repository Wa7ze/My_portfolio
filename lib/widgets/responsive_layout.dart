import 'package:flutter/material.dart';
import 'left_sidebar.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget child;
  final String currentPage;
  
  const ResponsiveLayout({
    super.key,
    required this.child,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 768) {
          // Mobile layout
          return Scaffold(
            appBar: AppBar(
              title: const Text('Mazen'),
              backgroundColor: Colors.white,
              elevation: 0,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.black),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),
            drawer: Drawer(
              child: LeftSidebar(currentPage: currentPage),
            ),
            body: child,
          );
        } else {
          // Desktop layout
          return Scaffold(
            body: Row(
              children: [
                LeftSidebar(currentPage: currentPage),
                Expanded(child: child),
              ],
            ),
          );
        }
      },
    );
  }
}
