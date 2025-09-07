import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LeftSidebar extends StatelessWidget {
  final String currentPage;
  
  const LeftSidebar({
    super.key,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A), // Dark background for contrast
        border: Border(
          right: BorderSide(color: Colors.grey.withOpacity(0.3)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(3, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          // Name with hover effect
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => context.go('/'),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Mazen Matran',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ),
            ),
          ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1),
          const SizedBox(height: 32),
          // Navigation with staggered animations
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _NavItem(
                  label: 'Home',
                  onTap: () => context.go('/'),
                  isActive: currentPage == 'home',
                ).animate(delay: 100.ms).fadeIn(duration: 500.ms).slideX(begin: -0.1),
                const SizedBox(height: 16),
                _NavItem(
                  label: 'My Work',
                  onTap: () => context.go('/work'),
                  isActive: currentPage == 'work',
                ).animate(delay: 200.ms).fadeIn(duration: 500.ms).slideX(begin: -0.1),
                const SizedBox(height: 16),
                _NavItem(
                  label: 'Get in touch',
                  onTap: () => context.go('/contact'),
                  isActive: currentPage == 'contact',
                ).animate(delay: 300.ms).fadeIn(duration: 500.ms).slideX(begin: -0.1),
              ],
            ),
          ),
          const Spacer(),
          // Footer with animation
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '© 2025 Mazen Matran. All rights reserved.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Built with Flutter',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.6),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ).animate(delay: 400.ms).fadeIn(duration: 500.ms).slideY(begin: 0.1),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  const _NavItem({
    required this.label,
    required this.onTap,
    required this.isActive,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: widget.isActive 
                ? Colors.white.withOpacity(0.15) 
                : _isHovered 
                    ? Colors.white.withOpacity(0.08) 
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: widget.isActive 
                ? Border.all(color: Colors.white.withOpacity(0.3), width: 1)
                : null,
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w500,
              color: widget.isActive 
                  ? Colors.white 
                  : _isHovered 
                      ? Colors.white.withOpacity(0.8) 
                      : Colors.white.withOpacity(0.7),
            ) ?? const TextStyle(),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}
