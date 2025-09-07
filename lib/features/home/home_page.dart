import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../widgets/responsive_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      currentPage: 'home',
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF0F8FF), // Very light blue (almost white)
              Color(0xFFE6F3FF), // Light blue
              Color(0xFFB3D9FF), // Medium blue
              Color(0xFF6B9BD2), // Your faded blue
              Color(0xFF4A7BA7), // Deeper blue
            ],
            stops: [0.0, 0.3, 0.6, 0.8, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Hero Section with wave background
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Stack(
                  children: [
                    // Wave background pattern
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _WavePainter(),
                      ),
                    ),
                    // Content
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Software Engineer',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(0, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.1),
                          const SizedBox(height: 16),
                          Text(
                            'Building innovative solutions with Flutter, Python, and AI.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(0, 1),
                                  blurRadius: 2,
                                ),
                              ],
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
                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xFF4A7BA7),
                                  elevation: 4,
                                ),
                                child: const Text('See My Work'),
                              ).animate(delay: 400.ms).fadeIn(duration: 600.ms).scale(begin: const Offset(0.8, 0.8)),
                              OutlinedButton(
                                onPressed: () => context.go('/contact'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  side: const BorderSide(color: Colors.white, width: 2),
                                ),
                                child: const Text('Get in touch'),
                              ).animate(delay: 500.ms).fadeIn(duration: 600.ms).scale(begin: const Offset(0.8, 0.8)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // About Me Section with fade effect
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.0),
                      Colors.white.withOpacity(0.3),
                      Colors.white.withOpacity(0.7),
                      Colors.white.withOpacity(0.9),
                      Colors.white,
                    ],
                    stops: const [0.0, 0.2, 0.4, 0.7, 1.0],
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About Me',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ).animate(delay: 600.ms).fadeIn(duration: 600.ms).slideX(begin: -0.1),
                    const SizedBox(height: 24),
                    
                    // Profile Text
                    Text(
                      'I\'m a fresh Software Engineer graduate with a minor in Computer Engineering from Üsküdar University. I\'m passionate about coding and enjoy exploring different areas of software development - from game development to app development and web development.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                        color: Colors.black87,
                      ),
                    ).animate(delay: 700.ms).fadeIn(duration: 600.ms).slideY(begin: 0.1),
                    
                    const SizedBox(height: 16),
                    
                    Text(
                      'I have strong communication skills and excel at handling various situations. I\'m open to full-time positions, part-time opportunities, or traineeships in Web development, App devolepment or Game development opportunities.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                        color: Colors.black87,
                      ),
                    ).animate(delay: 800.ms).fadeIn(duration: 600.ms).slideY(begin: 0.1),
                    
                    const SizedBox(height: 32),
                    
                    // Education & Skills Grid
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return constraints.maxWidth > 768 
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _buildEducationCard(context),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  child: _buildSkillsCard(context),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                _buildEducationCard(context),
                                const SizedBox(height: 24),
                                _buildSkillsCard(context),
                              ],
                            );
                      },
                    ),
                    
                    const SizedBox(height: 32),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildEducationCard(BuildContext context) {
    return Container(
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
            'Education',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          _buildEducationItem(
            context,
            'Bachelor\'s Degree',
            'Software Engineering',
            'Üsküdar University',
            'GPA: 3.65/4.0',
            '2021 - 2025',
          ),
          const SizedBox(height: 12),
          _buildEducationItem(
            context,
            'Minor Degree',
            'Computer Engineering',
            'Üsküdar University',
            'GPA: 3.0/4.0',
            '2022 - 2025',
          ),
        ],
      ),
    );
  }
  
  Widget _buildEducationItem(BuildContext context, String degree, String field, String university, String gpa, String period) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          degree,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF6B9BD2),
          ),
        ),
        Text(
          field,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        Text(
          university,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              gpa,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            Text(
              period,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildSkillsCard(BuildContext context) {
    final skills = [
      'Flutter', 'Python', 'Django', 'Laravel', 'PHP',
      'Java', 'C++', 'MySQL', 'HTML', 'Unity', 'Game Development',
      'TensorFlow', 'AI/ML'
    ];
    
    return Container(
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
            'Technical Skills',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((skill) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF6B9BD2).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF6B9BD2).withOpacity(0.3),
                ),
              ),
              child: Text(
                skill,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF6B9BD2),
                  fontWeight: FontWeight.w500,
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;

    final path = Path();
    
    // Create wave pattern
    final waveHeight = size.height * 0.3;
    final waveLength = size.width / 2;
    
    // First wave (bottom layer - darker blue)
    paint.color = const Color(0xFF2C5F8A).withOpacity(0.8);
    path.reset();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
      size.width * 0.25, size.height - waveHeight * 0.8,
      size.width * 0.5, size.height - waveHeight * 0.6,
    );
    path.quadraticBezierTo(
      size.width * 0.75, size.height - waveHeight * 0.4,
      size.width, size.height - waveHeight * 0.2,
    );
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
    
    // Second wave (middle layer)
    paint.color = const Color(0xFF4A7BA7).withOpacity(0.6);
    path.reset();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
      size.width * 0.3, size.height - waveHeight * 0.6,
      size.width * 0.6, size.height - waveHeight * 0.4,
    );
    path.quadraticBezierTo(
      size.width * 0.8, size.height - waveHeight * 0.2,
      size.width, size.height - waveHeight * 0.1,
    );
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
    
    // Third wave (top layer - lighter)
    paint.color = const Color(0xFF6B9BD2).withOpacity(0.4);
    path.reset();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
      size.width * 0.2, size.height - waveHeight * 0.4,
      size.width * 0.4, size.height - waveHeight * 0.3,
    );
    path.quadraticBezierTo(
      size.width * 0.6, size.height - waveHeight * 0.2,
      size.width * 0.8, size.height - waveHeight * 0.1,
    );
    path.quadraticBezierTo(
      size.width * 0.9, size.height - waveHeight * 0.05,
      size.width, size.height,
    );
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
    
    // Add white accent lines
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    
    // First accent line
    final linePath1 = Path();
    linePath1.moveTo(0, size.height - waveHeight * 0.8);
    linePath1.quadraticBezierTo(
      size.width * 0.25, size.height - waveHeight * 0.6,
      size.width * 0.5, size.height - waveHeight * 0.4,
    );
    linePath1.quadraticBezierTo(
      size.width * 0.75, size.height - waveHeight * 0.2,
      size.width, size.height - waveHeight * 0.1,
    );
    canvas.drawPath(linePath1, linePaint);
    
    // Second accent line
    linePaint.strokeWidth = 1.0;
    linePaint.color = Colors.white.withOpacity(0.4);
    final linePath2 = Path();
    linePath2.moveTo(0, size.height - waveHeight * 0.6);
    linePath2.quadraticBezierTo(
      size.width * 0.3, size.height - waveHeight * 0.4,
      size.width * 0.6, size.height - waveHeight * 0.2,
    );
    linePath2.quadraticBezierTo(
      size.width * 0.8, size.height - waveHeight * 0.1,
      size.width, size.height - waveHeight * 0.05,
    );
    canvas.drawPath(linePath2, linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
