import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../widgets/reveal_on_scroll.dart';
import 'work_card.dart';
import 'work_data.dart';

class WorkPage extends StatelessWidget {
  const WorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final cross = width >= 1280 ? 3 : width >= 900 ? 2 : 1;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      children: [
        RevealOnScroll(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Work', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text('Case studies & selected projects.',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black54)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: workItems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cross,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1.35,
          ),
          itemBuilder: (_, i) => RevealOnScroll(
            delay: (i * 80).ms,
            child: WorkCard(item: workItems[i]),
          ),
        ),
        const SizedBox(height: 36),
      ],
    );
  }
}
