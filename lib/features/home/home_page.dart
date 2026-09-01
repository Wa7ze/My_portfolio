import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/strings/app_strings.dart';
import '../../widgets/centered_content.dart';
import '../../widgets/cv_section.dart';
import '../../widgets/float_on_scroll.dart';
import '../../widgets/responsive_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final heroTextColor = isDark ? Colors.white : theme.colorScheme.onSurface;
    final heroShadow = isDark
        ? [Shadow(color: Colors.black.withOpacity(0.35), offset: const Offset(0, 2), blurRadius: 6)]
        : <Shadow>[];

    return ResponsiveLayout(
      currentPage: 'home',
      // Transparent so the app-wide CosmicBackground shows through instead
      // of a page-specific backdrop.
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.72,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        strings.heroTitle,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: heroTextColor,
                          shadows: heroShadow,
                        ),
                      ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.1),
                      const SizedBox(height: 16),
                      Text(
                        strings.heroSubtitle,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: heroTextColor.withOpacity(0.85),
                        ),
                      ).animate(delay: 200.ms).fadeIn(duration: 600.ms).slideY(begin: 0.1),
                      const SizedBox(height: 28),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        alignment: WrapAlignment.center,
                        children: [
                          FilledButton(
                            onPressed: () => context.go('/work'),
                            style: FilledButton.styleFrom(elevation: 4),
                            child: Text(strings.heroCtaWork),
                          ).animate(delay: 400.ms).fadeIn(duration: 600.ms).scale(begin: const Offset(0.8, 0.8)),
                          OutlinedButton(
                            onPressed: () => context.go('/contact'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: heroTextColor,
                              side: BorderSide(color: heroTextColor.withOpacity(0.6), width: 2),
                            ),
                            child: Text(strings.heroCtaContact),
                          ).animate(delay: 500.ms).fadeIn(duration: 600.ms).scale(begin: const Offset(0.8, 0.8)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 56),
              child: CenteredContent(
                child: FloatOnScroll(
                  intensity: 0.09,
                  weight: 0.8,
                  maxOffset: 18,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strings.aboutTeaserTitle,
                        style: theme.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w800),
                      ).animate(delay: 600.ms).fadeIn(duration: 600.ms).slideX(begin: -0.1),
                      const SizedBox(height: 20),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 720),
                        child: Text(
                          strings.aboutTeaserBody,
                          style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
                        ),
                      ).animate(delay: 700.ms).fadeIn(duration: 600.ms).slideY(begin: 0.1),
                      const SizedBox(height: 24),
                      OutlinedButton.icon(
                        onPressed: () => context.go('/about'),
                        icon: const Icon(Icons.arrow_forward, size: 18),
                        label: Text(strings.aboutTeaserCta),
                      ).animate(delay: 800.ms).fadeIn(duration: 600.ms).slideY(begin: 0.1),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 56),
              child: CenteredContent(child: const CvSection()),
            ),
          ],
        ),
      ),
    );
  }
}
