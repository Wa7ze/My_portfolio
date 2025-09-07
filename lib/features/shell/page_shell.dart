import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageShell extends StatelessWidget {
  final Widget child;
  const PageShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _Header(),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: child,
          ),
        ),
      ),
      bottomNavigationBar: const _Footer(),
    );
  }
}

class _Header extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final location = GoRouter.of(context).location; // e.g., "/" or "/work"
    TextStyle linkStyle(String path) {
      final selected = location == path || (path != '/' && location.startsWith(path));
      return TextStyle(
        fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
        color: selected ? Theme.of(context).colorScheme.primary : Colors.black87,
      );
    }

    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      titleSpacing: 16,
      title: Row(
        children: [
          GestureDetector(
            onTap: () => context.go('/'),
            child: Row(
              children: [
                const FlutterLogo(size: 28),
                const SizedBox(width: 8),
                Text('Portfolio', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
          const Spacer(),
          TextButton(onPressed: () => context.go('/work'), child: Text('Work', style: linkStyle('/work'))),
          const SizedBox(width: 12),
          TextButton(onPressed: () => context.go('/about'), child: Text('About', style: linkStyle('/about'))),
          const SizedBox(width: 12),
          FilledButton.tonal(onPressed: () => context.go('/contact'), child: const Text('Contact')),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

extension on GoRouter {
   get location => null;
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      color: Colors.white,
      child: Center(
        child: Text(
          '© ${DateTime.now().year} Your Name — Built with Flutter',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
