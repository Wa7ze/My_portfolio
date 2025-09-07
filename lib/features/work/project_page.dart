import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
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

    return ResponsiveLayout(
      currentPage: 'work',
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          // Back button
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.grey[100],
                  foregroundColor: Colors.black87,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Back to Projects',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1),
          
          const SizedBox(height: 24),
          
          // Project Header
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: item.tags.map((tag) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6B9BD2).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF6B9BD2).withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    tag,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF6B9BD2),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )).toList(),
              ).animate(delay: 100.ms).fadeIn(duration: 600.ms).slideY(begin: 0.1),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Project Overview
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Project Overview',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ).animate(delay: 200.ms).fadeIn(duration: 600.ms).slideX(begin: -0.1),
                const SizedBox(height: 16),
                Text(
                  item.overview,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                    color: Colors.black87,
                  ),
                ).animate(delay: 300.ms).fadeIn(duration: 600.ms).slideY(begin: 0.1),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Image Gallery
          Text(
            'Project Gallery',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ).animate(delay: 400.ms).fadeIn(duration: 600.ms).slideX(begin: -0.1),
          const SizedBox(height: 16),
          
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
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _buildImage(item.galleryImages[index]),
                    ),
                  ).animate(delay: (500 + index * 100).ms)
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: 0.1);
                },
              );
            },
          ),
          
          const SizedBox(height: 32),
          
          // GitHub Link
          Center(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF6B9BD2),
                    const Color(0xFF4A7BA7),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6B9BD2).withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _launchGitHub(item.githubUrl),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.code,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'View on GitHub',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.open_in_new,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ).animate(delay: 800.ms).fadeIn(duration: 600.ms).scale(begin: const Offset(0.8, 0.8)),
          
          const SizedBox(height: 48),
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
  
  Widget _buildImage(String imagePath) {
    // Check if it's a local asset or network URL
    if (imagePath.startsWith('images/') || imagePath.startsWith('assets/')) {
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: const Icon(Icons.image, size: 50, color: Colors.grey),
          );
        },
      );
    } else {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: const Icon(Icons.image, size: 50, color: Colors.grey),
          );
        },
      );
    }
  }
}