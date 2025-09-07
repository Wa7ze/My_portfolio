import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageShell extends StatelessWidget {
  final Widget child;
  const PageShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio'),
        backgroundColor: Colors.blue,
      ),
      body: child,
      bottomNavigationBar: Container(
        color: Colors.green,
        padding: const EdgeInsets.all(16),
        child: const Text(
          'FOOTER IS WORKING!',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

