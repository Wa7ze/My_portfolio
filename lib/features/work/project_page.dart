import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/strings/app_strings.dart';
import '../../core/theme.dart';
import '../../widgets/centered_content.dart';
import '../../widgets/float_on_scroll.dart';
import '../../widgets/responsive_layout.dart';
import 'work_data.dart';

class ProjectPage extends StatelessWidget {
  final String slug;
  const ProjectPage({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    final item = workItems.firstWhere(
      (w) => w.slug == slug,
      orElse: () => workItems.first,
    );
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
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Directionality.of(context) == TextDirection.rtl ? Icons.arrow_forward : Icons.arrow_back),
                style: IconButton.styleFrom(
                  backgroundColor: context.palette.cardBackground,
                  foregroundColor: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(width: 16),
              Text(strings.backToProjects, style: theme.textTheme.bodyMedium?.copyWith(color: context.palette.mutedText)),
            ],
          ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1),

          const SizedBox(height: 24),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title, style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800))
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: 0.1),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: item.tags
                    .map((tag) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: theme.colorScheme.primary.withOpacity(0.3)),
                          ),
                          child: Text(
                            tag,
                            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w500),
                          ),
                        ))
                    .toList(),
              ).animate(delay: 100.ms).fadeIn(duration: 600.ms).slideY(begin: 0.1),
            ],
          ),

          const SizedBox(height: 32),

          FloatOnScroll(
            intensity: 0.10,
            weight: 0.8,
            maxOffset: 24,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: context.palette.cardBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.palette.cardBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(strings.projectOverview, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700))
                      .animate(delay: 200.ms)
                      .fadeIn(duration: 600.ms)
                      .slideX(begin: -0.1),
                  const SizedBox(height: 16),
                  Text(item.overview, style: theme.textTheme.bodyLarge?.copyWith(height: 1.6))
                      .animate(delay: 300.ms)
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: 0.1),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),

          Text(strings.projectGallery, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700))
              .animate(delay: 400.ms)
              .fadeIn(duration: 600.ms)
              .slideX(begin: -0.1),
          const SizedBox(height: 16),

          if (item.galleryImages.isEmpty)
            Container(
              padding: const EdgeInsets.all(32),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.palette.cardBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.palette.cardBorder),
              ),
              child: Icon(Icons.photo_library_outlined, size: 40, color: theme.colorScheme.primary.withOpacity(0.6)),
            ).animate(delay: 500.ms).fadeIn(duration: 600.ms)
          else
            LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 768;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isMobile ? 1 : 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: isMobile ? 1.5 : 1.2,
                  ),
                  itemCount: item.galleryImages.length,
                  itemBuilder: (context, index) {
                    return FloatOnScroll(
                      intensity: 0.08,
                      weight: 0.5,
                      maxOffset: 18,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 10, offset: const Offset(0, 4)),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: _buildImage(context, item.galleryImages[index]),
                        ),
                      ).animate(delay: (500 + index * 100).ms).fadeIn(duration: 600.ms).slideY(begin: 0.1),
                    );
                  },
                );
              },
            ),

          const SizedBox(height: 32),

          Center(
            child: Material(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () => _launchGitHub(item.githubUrl),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.code, color: theme.colorScheme.onPrimary, size: 24),
                      const SizedBox(width: 12),
                      Text(
                        strings.viewOnGithub,
                        style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.open_in_new, color: theme.colorScheme.onPrimary, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          ).animate(delay: 800.ms).fadeIn(duration: 600.ms).scale(begin: const Offset(0.8, 0.8)),

          const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchGitHub(String url) async {
    final Uri githubUri = Uri.parse(url);
    if (await canLaunchUrl(githubUri)) {
      await launchUrl(githubUri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildImage(BuildContext context, String imagePath) {
    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: context.palette.cardBackground,
          child: Icon(Icons.image_outlined, size: 50, color: Theme.of(context).colorScheme.primary.withOpacity(0.6)),
        );
      },
    );
  }
}
