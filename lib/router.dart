import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/shell/page_shell.dart';
import 'features/home/home_page.dart';
import 'features/work/work_page.dart';
import 'features/work/project_page.dart';
import 'features/about/about_page.dart';
import 'features/contact/contact_page.dart';

final router = GoRouter(
  initialLocation: '/',   // <- ensures "/" is the first page
  routes: [
    ShellRoute(
      builder: (ctx, state, child) => PageShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (ctx, st) => const HomePage(),
        ),
        GoRoute(
          path: '/work',
          name: 'work',
          builder: (ctx, st) => const WorkPage(),
        ),
        GoRoute(
          path: '/work/:slug',
          name: 'project',
          pageBuilder: (ctx, st) {
            final slug = st.pathParameters['slug']!;
            return CustomTransitionPage(
              child: ProjectPage(slug: slug),
              transitionsBuilder: (ctx, anim, sec, child) => FadeTransition(
                opacity: CurvedAnimation(parent: anim, curve: Curves.easeInOut),
                child: SlideTransition(
                  position: Tween(begin: const Offset(0, .02), end: Offset.zero)
                      .chain(CurveTween(curve: Curves.easeInOut))
                      .animate(anim),
                  child: child,
                ),
              ),
            );
          },
        ),
        GoRoute(
          path: '/about',
          name: 'about',
          builder: (ctx, st) => const AboutPage(),
        ),
        GoRoute(
          path: '/contact',
          name: 'contact',
          builder: (ctx, st) => const ContactPage(),
        ),
      ],
    ),
  ],
  errorBuilder: (ctx, st) => const Scaffold(
    body: Center(child: Text('404 – Page not found')),
  ),
);
