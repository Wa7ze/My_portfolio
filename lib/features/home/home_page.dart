import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/planet_theme.dart';
import '../../core/strings/app_strings.dart';
import '../../core/theme.dart';
import '../../widgets/centered_content.dart';
import '../../widgets/cv_section.dart';
import '../../widgets/float_on_scroll.dart';
import '../../widgets/planet_dot.dart';
import '../../widgets/responsive_layout.dart';
import '../about/certificate_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    final theme = Theme.of(context);
    final aboutAccent = kPlanetThemes['about']!.color;

    return ResponsiveLayout(
      currentPage: 'home',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 88, 16, 24),
        children: [
          CenteredContent(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name, title, and "About Me" heading — centered, unlike
                // the card content below.
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Mazen Matran',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w800),
                      ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.1),
                      const SizedBox(height: 6),
                      Text(
                        strings.heroTitle,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w700),
                      ).animate(delay: 100.ms).fadeIn(duration: 600.ms).slideY(begin: 0.1),
                      const SizedBox(height: 20),
                      Text(
                        strings.aboutTeaserTitle,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w800),
                      ).animate(delay: 200.ms).fadeIn(duration: 600.ms).slideX(begin: -0.1),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                FloatOnScroll(
                  intensity: 0.09,
                  weight: 0.85,
                  maxOffset: 20,
                  child: _Section(
                    title: strings.summaryTitle,
                    delay: 150,
                    child: Text(
                      strings.summaryBody,
                      style: theme.textTheme.bodyLarge?.copyWith(height: 1.65),
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                FloatOnScroll(
                  intensity: 0.09,
                  weight: 0.85,
                  maxOffset: 20,
                  child: _Section(
                    title: strings.experienceTitle,
                    delay: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 12,
                          runSpacing: 4,
                          children: [
                            Text(strings.experienceRole, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: aboutAccent)),
                            Text(strings.experienceCompany, style: theme.textTheme.bodyMedium?.copyWith(color: context.palette.mutedText)),
                            Text(strings.experiencePeriod, style: theme.textTheme.bodySmall?.copyWith(color: context.palette.mutedText, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ...strings.experienceBullets.map(
                          (b) => Padding(
                            padding: const EdgeInsetsDirectional.only(bottom: 8),
                            child: _BulletLine(text: b),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                LayoutBuilder(
                  builder: (context, constraints) {
                    final wide = constraints.maxWidth > 768;
                    final educationCard = FloatOnScroll(
                      intensity: 0.09,
                      weight: 0.8,
                      maxOffset: 18,
                      child: _Section(
                        title: strings.educationTitle,
                        delay: 350,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (final entry in strings.educationEntries) ...[
                              _EducationTile(entry: entry),
                              if (entry != strings.educationEntries.last) const SizedBox(height: 16),
                            ],
                          ],
                        ),
                      ),
                    );
                    final skillsCard = FloatOnScroll(
                      intensity: 0.09,
                      weight: 0.8,
                      maxOffset: 18,
                      child: _Section(
                        title: strings.skillsTitle,
                        delay: 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (final group in strings.skillGroups.entries) ...[
                              Text(group.key, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700, color: aboutAccent)),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: group.value.map((s) => _SkillChip(label: s)).toList(),
                              ),
                              if (group.key != strings.skillGroups.keys.last) const SizedBox(height: 16),
                            ],
                          ],
                        ),
                      ),
                    );
                    return wide
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: educationCard),
                              const SizedBox(width: 24),
                              Expanded(child: skillsCard),
                            ],
                          )
                        : Column(children: [educationCard, const SizedBox(height: 24), skillsCard]);
                  },
                ),
                const SizedBox(height: 28),

                FloatOnScroll(
                  intensity: 0.09,
                  weight: 0.7,
                  maxOffset: 16,
                  child: _Section(
                    title: strings.languagesTitle,
                    delay: 450,
                    child: Wrap(
                      spacing: 24,
                      runSpacing: 12,
                      children: strings.languageEntries
                          .map((l) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(l.name, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                                  Text(l.level, style: theme.textTheme.bodySmall?.copyWith(color: context.palette.mutedText)),
                                ],
                              ))
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                Text(strings.certificatesTitle, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800))
                    .animate(delay: 500.ms)
                    .fadeIn(duration: 600.ms)
                    .slideX(begin: -0.1),
                const SizedBox(height: 4),
                Text(strings.certificatesSubtitle, style: theme.textTheme.titleMedium?.copyWith(color: context.palette.mutedText))
                    .animate(delay: 550.ms)
                    .fadeIn(duration: 600.ms),
                const SizedBox(height: 20),
                _CertificateGrid(items: featuredCertificates, delayBase: 600),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(child: Divider(color: theme.dividerColor)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        strings.otherCertificatesLabel,
                        style: theme.textTheme.bodySmall?.copyWith(color: context.palette.mutedText, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(child: Divider(color: theme.dividerColor)),
                  ],
                ).animate(delay: 650.ms).fadeIn(duration: 500.ms),
                const SizedBox(height: 28),
                _CertificateGrid(items: certificates, delayBase: 700),
                const SizedBox(height: 48),

                // CTAs, moved to the bottom, each carrying the same planet
                // symbol as its sidebar item — clicking either navigates
                // just like the sidebar would, so the same camera "fly
                // toward" animation plays in the background.
                Center(
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: [
                      FilledButton.icon(
                        onPressed: () => context.go('/work'),
                        icon: PlanetDot(color: Colors.white, hasRing: kPlanetThemes['work']!.hasRing, size: 16),
                        label: Text(strings.heroCtaWork),
                        style: FilledButton.styleFrom(
                          backgroundColor: kPlanetThemes['work']!.color,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        ),
                      ).animate(delay: 750.ms).fadeIn(duration: 600.ms).scale(begin: const Offset(0.85, 0.85)),
                      OutlinedButton.icon(
                        onPressed: () => context.go('/contact'),
                        icon: PlanetDot(color: kPlanetThemes['contact']!.color, hasRing: kPlanetThemes['contact']!.hasRing, size: 16),
                        label: Text(strings.heroCtaContact),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: kPlanetThemes['contact']!.color,
                          side: BorderSide(color: kPlanetThemes['contact']!.color.withOpacity(0.6), width: 2),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        ),
                      ).animate(delay: 850.ms).fadeIn(duration: 600.ms).scale(begin: const Offset(0.85, 0.85)),
                    ],
                  ),
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

class _Section extends StatelessWidget {
  final String title;
  final Widget child;
  final int delay;
  const _Section({required this.title, required this.child, required this.delay});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.palette.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.palette.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          child,
        ],
      ),
    ).animate(delay: delay.ms).fadeIn(duration: 600.ms).slideY(begin: 0.08);
  }
}

class _BulletLine extends StatelessWidget {
  final String text;
  const _BulletLine({required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: kPlanetThemes['about']!.color, shape: BoxShape.circle),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: theme.textTheme.bodyMedium?.copyWith(height: 1.5))),
      ],
    );
  }
}

class _EducationTile extends StatelessWidget {
  final EducationEntry entry;
  const _EducationTile({required this.entry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(entry.degree, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: kPlanetThemes['about']!.color)),
        Text(entry.field, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500)),
        Text(entry.school, style: theme.textTheme.bodyMedium?.copyWith(color: context.palette.mutedText)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(entry.gpa, style: theme.textTheme.bodySmall?.copyWith(color: context.palette.mutedText)),
            Text(entry.period, style: theme.textTheme.bodySmall?.copyWith(color: context.palette.mutedText, fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  const _SkillChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.primary.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _CertificateGrid extends StatelessWidget {
  final List<CertificateData> items;
  final int delayBase;
  const _CertificateGrid({required this.items, required this.delayBase});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final cross = width >= 900 ? 3 : width >= 600 ? 2 : 1;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cross,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.35,
          ),
          itemBuilder: (_, i) => FloatOnScroll(
            intensity: 0.08,
            weight: 0.2,
            maxOffset: 6,
            reserveSpace: false,
            child: _CertificateCard(data: items[i])
                .animate(delay: (delayBase + i * 80).ms)
                .fadeIn(duration: 500.ms)
                .slideY(begin: 0.1),
          ),
        );
      },
    );
  }
}

class _CertificateCard extends StatelessWidget {
  final CertificateData data;
  const _CertificateCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => showDialog(
          context: context,
          builder: (_) => _CertificateDialog(data: data),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: context.palette.cardBackground,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: context.palette.cardBorder),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ColoredBox(color: theme.colorScheme.primary.withOpacity(0.06)),
                    if (data.imageAsset != null)
                      Image.asset(data.imageAsset!, fit: BoxFit.contain)
                    else
                      Icon(Icons.workspace_premium_outlined, size: 40, color: theme.colorScheme.primary),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(12, 20, 12, 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black.withOpacity(0.72)],
                          ),
                        ),
                        child: Text(
                          data.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.issuer,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(color: context.palette.mutedText),
                          ),
                          Text(
                            data.date,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    if (data.url != null) Icon(Icons.open_in_new, size: 14, color: theme.colorScheme.primary),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CertificateDialog extends StatelessWidget {
  final CertificateData data;
  const _CertificateDialog({required this.data});

  Future<void> _openLink() async {
    final url = data.url;
    if (url == null) return;
    final uri = Uri.parse(url);
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
        constraints: const BoxConstraints(maxWidth: 820, maxHeight: 720),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(data.title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Text(
                '${data.issuer} · ${data.date}',
                style: theme.textTheme.bodySmall?.copyWith(color: context.palette.mutedText),
              ),
              const SizedBox(height: 12),
              if (data.imageAsset != null)
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: InteractiveViewer(
                      child: Image.asset(data.imageAsset!, fit: BoxFit.contain),
                    ),
                  ),
                ),
              if (data.url != null) ...[
                const SizedBox(height: 16),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: OutlinedButton.icon(
                    onPressed: _openLink,
                    icon: const Icon(Icons.open_in_new, size: 16),
                    label: Text(strings.verificationLinkLabel),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
