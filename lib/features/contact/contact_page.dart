import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/strings/app_strings.dart';
import '../../core/theme.dart';
import '../../widgets/centered_content.dart';
import '../../widgets/float_on_scroll.dart';
import '../../widgets/responsive_layout.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});
  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    final theme = Theme.of(context);

    return ResponsiveLayout(
      currentPage: 'contact',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 88, 16, 24),
        children: [
          CenteredContent(
            maxWidth: 760,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(strings.contactTitle, style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800))
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.1),
                const SizedBox(height: 16),
                Text(
                  strings.contactSubtitle,
                  style: theme.textTheme.bodyLarge?.copyWith(color: context.palette.mutedText, height: 1.5),
                ).animate(delay: 100.ms).fadeIn(duration: 600.ms).slideY(begin: 0.1),
                const SizedBox(height: 48),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile = constraints.maxWidth < 560;
                    return GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: isMobile ? 1 : 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: isMobile ? 3.5 : 2.8,
                      children: [
                        FloatOnScroll(
                          intensity: 0.09,
                          weight: 0.4,
                          maxOffset: 16,
                          child: _buildContactBox(
                            context,
                            icon: Icons.email,
                            title: strings.contactEmailLabel,
                            subtitle: 'mmazen0132@gmail.com',
                            onTap: () => _launchEmail(),
                          ).animate(delay: 200.ms).fadeIn(duration: 600.ms).slideY(begin: 0.1),
                        ),
                        FloatOnScroll(
                          intensity: 0.09,
                          weight: 0.4,
                          maxOffset: 16,
                          child: _buildContactBox(
                            context,
                            icon: Icons.phone,
                            title: strings.contactPhoneLabel,
                            subtitle: '+966 54 674 8006',
                            onTap: () => _launchWhatsApp(),
                          ).animate(delay: 300.ms).fadeIn(duration: 600.ms).slideY(begin: 0.1),
                        ),
                        FloatOnScroll(
                          intensity: 0.09,
                          weight: 0.4,
                          maxOffset: 16,
                          child: _buildContactBox(
                            context,
                            icon: Icons.work,
                            title: strings.contactLinkedinLabel,
                            subtitle: 'Mazen Matran',
                            onTap: () => _launchLinkedIn(),
                          ).animate(delay: 400.ms).fadeIn(duration: 600.ms).slideY(begin: 0.1),
                        ),
                        FloatOnScroll(
                          intensity: 0.09,
                          weight: 0.4,
                          maxOffset: 16,
                          child: _buildContactBox(
                            context,
                            icon: Icons.code,
                            title: strings.contactGithubLabel,
                            subtitle: 'Wa7ze',
                            onTap: () => _launchGitHub(),
                          ).animate(delay: 500.ms).fadeIn(duration: 600.ms).slideY(begin: 0.1),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 48),
                Text(strings.downloadCvTitle, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800))
                    .animate(delay: 600.ms)
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.1),
                const SizedBox(height: 16),
                Center(
                  child: FilledButton.icon(
                    onPressed: () => _downloadCV(),
                    icon: const Icon(Icons.download),
                    label: Text(strings.downloadCvButton),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ).animate(delay: 700.ms).fadeIn(duration: 600.ms).slideY(begin: 0.1),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactBox(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: context.palette.cardBackground,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 2))],
            border: Border.all(color: context.palette.cardBorder),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: theme.colorScheme.primary, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(scheme: 'mailto', path: 'mmazen0132@gmail.com', query: 'subject=Hello from Portfolio&body=Hi Mazen,');
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email copied to clipboard: mmazen0132@gmail.com')),
      );
    }
  }

  Future<void> _launchWhatsApp() async {
    final Uri whatsappUri = Uri.parse('https://wa.me/966546748006');
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not open WhatsApp')));
    }
  }

  Future<void> _launchLinkedIn() async {
    final Uri linkedinUri = Uri.parse('https://linkedin.com/in/mazen-matran');
    if (await canLaunchUrl(linkedinUri)) {
      await launchUrl(linkedinUri, mode: LaunchMode.externalApplication);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not open LinkedIn')));
    }
  }

  Future<void> _launchGitHub() async {
    final Uri githubUri = Uri.parse('https://github.com/Wa7ze');
    if (await canLaunchUrl(githubUri)) {
      await launchUrl(githubUri, mode: LaunchMode.externalApplication);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not open GitHub')));
    }
  }

  Future<void> _downloadCV() async {
    try {
      final url = Uri.parse('assets/files/Mazen_Matran_CV.pdf');
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("CV will open in a new tab. If it doesn't, please check your browser settings."),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error opening CV: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }
}
