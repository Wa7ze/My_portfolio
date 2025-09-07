import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../widgets/responsive_layout.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      currentPage: 'about',
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('About', style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: Colors.black,
              )).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1),
              const SizedBox(height: 8),
              Text('Short bio and capabilities.', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey,
              )).animate(delay: 100.ms).fadeIn(duration: 600.ms).slideX(begin: -0.1),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'I craft animated, accessible interfaces with Flutter, Web, and motion design. This page mirrors the original site\'s tone and layout but rebuilt in Flutter.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.55,
              color: Colors.black87,
            ),
          ).animate(delay: 200.ms).fadeIn(duration: 600.ms).slideY(begin: 0.1),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
