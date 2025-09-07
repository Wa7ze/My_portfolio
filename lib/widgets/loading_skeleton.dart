import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoadingSkeleton extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  
  const LoadingSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 20,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: borderRadius ?? BorderRadius.circular(4),
      ),
    ).animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 1500.ms, color: Colors.grey[400]!)
        .fadeIn(duration: 300.ms);
  }
}

class WorkCardSkeleton extends StatelessWidget {
  const WorkCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[100],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image skeleton
          Expanded(
            flex: 3,
            child: LoadingSkeleton(
              width: double.infinity,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
          ),
          // Content skeleton
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoadingSkeleton(width: 120, height: 16),
                  const SizedBox(height: 8),
                  LoadingSkeleton(width: 200, height: 12),
                  const SizedBox(height: 8),
                  LoadingSkeleton(width: 80, height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextSkeleton extends StatelessWidget {
  final int lines;
  final double? width;
  
  const TextSkeleton({
    super.key,
    this.lines = 1,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        lines,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: index < lines - 1 ? 8 : 0),
          child: LoadingSkeleton(
            width: width ?? (index == lines - 1 ? 150 : double.infinity),
            height: 16,
          ),
        ),
      ),
    );
  }
}
