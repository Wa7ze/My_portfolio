import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../widgets/responsive_layout.dart';
import 'work_card.dart';
import 'work_data.dart';

class WorkPage extends StatelessWidget {
  const WorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      currentPage: 'work',
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My Work', style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: Colors.black,
              )).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1),
              const SizedBox(height: 8),
              Text('Case studies & selected projects.',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey,
                  )).animate(delay: 100.ms).fadeIn(duration: 600.ms).slideX(begin: -0.1),
            ],
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final cross = width >= 1280 ? 3 : width >= 900 ? 2 : 1;
              
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: workItems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cross,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.35,
                ),
                itemBuilder: (_, i) => WorkCard(item: workItems[i])
                    .animate(delay: (200 + i * 100).ms)
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.1),
              );
            },
          ),
          const SizedBox(height: 36),
        ],
      ),
    );
  }
}
