import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/strings/app_strings.dart';
import '../core/theme.dart';

const _kCvImageAsset = 'assets/images/misc/cv_preview.jpg';
const _kCvPdfAsset = 'assets/files/Mazen_Matran_CV.pdf';

/// A "CV" section shown at the bottom of every page: a clickable preview
/// image that opens a zoomable full-size view, with a download button
/// underneath the popup.
class CvSection extends StatelessWidget {
  const CvSection({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(strings.cvSectionTitle, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800))
            .animate()
            .fadeIn(duration: 500.ms)
            .slideY(begin: 0.1),
        const SizedBox(height: 6),
        Text(strings.cvSectionSubtitle, style: theme.textTheme.titleMedium?.copyWith(color: context.palette.mutedText))
            .animate(delay: 80.ms)
            .fadeIn(duration: 500.ms),
        const SizedBox(height: 20),
        Center(
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => showDialog(context: context, builder: (_) => const _CvDialog()),
              child: Container(
                width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.palette.cardBorder),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 16, offset: const Offset(0, 8))],
                ),
                clipBehavior: Clip.antiAlias,
                child: AspectRatio(
                  aspectRatio: 0.773,
                  child: Image.asset(
                    _kCvImageAsset,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    errorBuilder: (context, error, stackTrace) => ColoredBox(
                      color: context.palette.cardBackground,
                      child: Icon(Icons.description_outlined, size: 40, color: theme.colorScheme.primary),
                    ),
                  ),
                ),
              ),
            ),
          ).animate(delay: 150.ms).fadeIn(duration: 500.ms).scale(begin: const Offset(0.9, 0.9)),
        ),
      ],
    );
  }
}

class _CvDialog extends StatelessWidget {
  const _CvDialog();

  Future<void> _download() async {
    final uri = Uri.parse(_kCvPdfAsset);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.strings;
    return Dialog(
      backgroundColor: theme.cardColor,
      insetPadding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640, maxHeight: 780),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(strings.cvSectionTitle, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                  ),
                  IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close)),
                ],
              ),
              const SizedBox(height: 8),
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: InteractiveViewer(
                    child: Image.asset(_kCvImageAsset, fit: BoxFit.contain),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _download,
                icon: const Icon(Icons.download),
                label: Text(strings.downloadCvButton),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
