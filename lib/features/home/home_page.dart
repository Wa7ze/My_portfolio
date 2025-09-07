import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/reveal_on_scroll.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;

    return ListView(
      children: [
        SizedBox(
          height: h * 0.72,
          child: Stack(
            children: [
              // Simple parallax-ish background block
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Colors.blue.withOpacity(.06)],
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Creative Developer & Designer',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        height: 1.05,
                      ),
                    ).animate().fadeIn(duration: 500.ms).slide(begin: const Offset(0, .08)),
                    const SizedBox(height: 16),
                    Text(
                      'Building animated, high-performance web experiences.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black54),
                    ).animate(delay: 150.ms).fadeIn(duration: 500.ms).slide(begin: const Offset(0, .06)),
                    const SizedBox(height: 28),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: [
                        FilledButton(
                          onPressed: () => context.go('/work'),
                          child: const Text('See Work'),
                        ),
                        OutlinedButton(
                          onPressed: () => context.go('/contact'),
                          child: const Text('Get in touch'),
                        ),
                      ],
                    ).animate(delay: 250.ms).fadeIn(duration: 450.ms),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RevealOnScroll(
            delay: 50.ms,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Featured Work', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Text('A selection of recent projects.', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black54)),
                const SizedBox(height: 16),
                FilledButton.tonal(
                  onPressed: () => context.go('/work'),
                  child: const Text('View the full case studies →'),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
