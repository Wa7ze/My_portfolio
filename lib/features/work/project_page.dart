import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'work_data.dart';

class ProjectPage extends StatelessWidget {
  final String slug;
  const ProjectPage({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    final item = workItems.firstWhere((w) => w.slug == slug, orElse: () => workItems.first);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(item.title, style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800))
                    .animate()
                    .fadeIn(duration: 400.ms)
                    .slide(begin: const Offset(0, .06)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: item.tags.map((t) => Chip(label: Text(t))).toList(),
                ),
              ]),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(item.imageUrl, height: 480, fit: BoxFit.cover),
        ).animate().fadeIn(duration: 500.ms),
        const SizedBox(height: 16),
        Text(
          item.summary,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black87, height: 1.45),
        ).animate(delay: 100.ms).fadeIn(duration: 400.ms),
        const SizedBox(height: 24),
        Text(
          'Process',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Text(
          'Outline discovery, design system, interaction prototypes, and performance work here.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black54, height: 1.5),
        ),
        const SizedBox(height: 48),
      ],
    );
  }
}
