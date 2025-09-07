import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../widgets/reveal_on_scroll.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      children: [
        RevealOnScroll(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('About', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text('Short bio and capabilities.', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black54)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'I craft animated, accessible interfaces with Flutter, Web, and motion design. '
          'This page mirrors the original site’s tone and layout but rebuilt in Flutter.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.55),
        ).animate().fadeIn(duration: 400.ms),
        const SizedBox(height: 48),
      ],
    );
  }
}
