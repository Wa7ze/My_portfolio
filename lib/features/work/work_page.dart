import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/strings/app_strings.dart';
import '../../core/theme.dart';
import '../../widgets/centered_content.dart';
import '../../widgets/cv_section.dart';
import '../../widgets/float_on_scroll.dart';
import '../../widgets/responsive_layout.dart';
import 'work_card.dart';
import 'work_data.dart';

class WorkPage extends StatelessWidget {
  const WorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    final theme = Theme.of(context);
    return ResponsiveLayout(
      currentPage: 'work',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 88, 16, 24),
        children: [
          CenteredContent(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(strings.workPageTitle, style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800))
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideX(begin: -0.1),
                const SizedBox(height: 8),
                Text(strings.workPageSubtitle, style: theme.textTheme.titleMedium?.copyWith(color: context.palette.mutedText))
                    .animate(delay: 100.ms)
                    .fadeIn(duration: 600.ms)
                    .slideX(begin: -0.1),
                const SizedBox(height: 24),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final cross = width >= 860
                        ? 3
                        : width >= 560
                            ? 2
                            : 1;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: workItems.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: cross,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 1.15,
                      ),
                      itemBuilder: (_, i) => FloatOnScroll(
                        intensity: 0.10,
                        weight: 0.85,
                        maxOffset: 8,
                        reserveSpace: false,
                        child: WorkCard(item: workItems[i]).animate(delay: (200 + i * 100).ms).fadeIn(duration: 600.ms).slideY(begin: 0.1),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 48),
                const CvSection(),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
