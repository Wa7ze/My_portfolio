import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/home/home_page.dart';
import 'features/work/work_page.dart';
import 'features/work/project_page.dart';
import 'features/about/about_page.dart';
import 'features/contact/contact_page.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      pageBuilder: (ctx, st) => CustomTransitionPage(
        child: const HomePage(),
        transitionsBuilder: (ctx, anim, sec, child) => FadeTransition(
          opacity: CurvedAnimation(parent: anim, curve: Curves.easeInOut),
          child: SlideTransition(
            position: Tween(begin: const Offset(0, 0.1), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeOutCubic))
                .animate(anim),
            child: child,
          ),
        ),
      ),
    ),
    GoRoute(
      path: '/work',
      name: 'work',
      pageBuilder: (ctx, st) => CustomTransitionPage(
        child: const WorkPage(),
        transitionsBuilder: (ctx, anim, sec, child) => FadeTransition(
          opacity: CurvedAnimation(parent: anim, curve: Curves.easeInOut),
          child: SlideTransition(
            position: Tween(begin: const Offset(0, 0.1), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeOutCubic))
                .animate(anim),
            child: child,
          ),
        ),
      ),
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
              position: Tween(begin: const Offset(0, 0.1), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeOutCubic))
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
      pageBuilder: (ctx, st) => CustomTransitionPage(
        child: const AboutPage(),
        transitionsBuilder: (ctx, anim, sec, child) => FadeTransition(
          opacity: CurvedAnimation(parent: anim, curve: Curves.easeInOut),
          child: SlideTransition(
            position: Tween(begin: const Offset(0, 0.1), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeOutCubic))
                .animate(anim),
            child: child,
          ),
        ),
      ),
    ),
    GoRoute(
      path: '/contact',
      name: 'contact',
      pageBuilder: (ctx, st) => CustomTransitionPage(
        child: const ContactPage(),
        transitionsBuilder: (ctx, anim, sec, child) => FadeTransition(
          opacity: CurvedAnimation(parent: anim, curve: Curves.easeInOut),
          child: SlideTransition(
            position: Tween(begin: const Offset(0, 0.1), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeOutCubic))
                .animate(anim),
            child: child,
          ),
        ),
      ),
    ),
  ],
  errorBuilder: (ctx, st) => const Scaffold(
    body: Center(child: Text('404 – Page not found')),
  ),
);
