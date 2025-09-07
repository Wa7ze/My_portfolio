import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/responsive_layout.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});
  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      currentPage: 'contact',
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          // Header
          Text('Get In Touch', style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w800,
            color: Colors.black,
          )).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1),
          const SizedBox(height: 16),
          Text('I\'m always open to discussing new opportunities, collaborations, or just having a chat about technology and coding.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
                height: 1.5,
              )).animate(delay: 100.ms).fadeIn(duration: 600.ms).slideY(begin: 0.1),
          const SizedBox(height: 48),
          
          // Contact Boxes Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 768;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: isMobile ? 1 : 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: isMobile ? 3.5 : 2.8,
                children: [
                  _buildContactBox(
                    context,
                    icon: Icons.email,
                    title: 'Email',
                    subtitle: 'Mmazen0132@gmail.com',
                    onTap: () => _launchEmail(),
                  ).animate(delay: 200.ms).fadeIn(duration: 600.ms).slideY(begin: 0.1),
                  _buildContactBox(
                    context,
                    icon: Icons.phone,
                    title: 'Phone',
                    subtitle: '(966)546748006',
                    onTap: () => _launchWhatsApp(),
                  ).animate(delay: 300.ms).fadeIn(duration: 600.ms).slideY(begin: 0.1),
                  _buildContactBox(
                    context,
                    icon: Icons.work,
                    title: 'LinkedIn',
                    subtitle: 'Mazen Matran',
                    onTap: () => _launchLinkedIn(),
                  ).animate(delay: 400.ms).fadeIn(duration: 600.ms).slideY(begin: 0.1),
                  _buildContactBox(
                    context,
                    icon: Icons.code,
                    title: 'GitHub',
                    subtitle: 'Wa7ze',
                    onTap: () => _launchGitHub(),
                  ).animate(delay: 500.ms).fadeIn(duration: 600.ms).slideY(begin: 0.1),
                ],
              );
            },
          ),
          
          const SizedBox(height: 48),
          
          // Download CV Section
          Text('Download My CV', style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: Colors.black,
          )).animate(delay: 600.ms).fadeIn(duration: 600.ms).slideY(begin: 0.1),
          const SizedBox(height: 16),
                  Center(
                    child: FilledButton.icon(
                      onPressed: () => _downloadCV(),
                      icon: const Icon(Icons.download),
                      label: const Text('Download Full CV'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ).animate(delay: 700.ms).fadeIn(duration: 600.ms).slideY(begin: 0.1),
                  ),
          
          const SizedBox(height: 48),
        ],
      ),
    );
  }
  
  Widget _buildContactBox(BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: Colors.grey.withOpacity(0.1),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6B9BD2).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF6B9BD2),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF6B9BD2),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'mmazen0132@gmail.com',
      query: 'subject=Hello from Portfolio&body=Hi Mazen,',
    );
    
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      // Fallback: copy email to clipboard
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email copied to clipboard: mmazen0132@gmail.com')),
      );
    }
  }
  
  Future<void> _launchWhatsApp() async {
    final Uri whatsappUri = Uri.parse('https://wa.me/966546748006');
    
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open WhatsApp')),
      );
    }
  }
  
  Future<void> _launchLinkedIn() async {
    final Uri linkedinUri = Uri.parse('https://linkedin.com/in/mazen-matran');
    
    if (await canLaunchUrl(linkedinUri)) {
      await launchUrl(linkedinUri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open LinkedIn')),
      );
    }
  }
  
  Future<void> _launchGitHub() async {
    final Uri githubUri = Uri.parse('https://github.com/Wa7ze');
    
    if (await canLaunchUrl(githubUri)) {
      await launchUrl(githubUri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open GitHub')),
      );
    }
  }

  Future<void> _downloadCV() async {
    try {
      // For web, we'll open the CV in a new tab
      final url = Uri.parse('assets/files/Mazen\'s CV F.pdf');
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        // Fallback: show a message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('CV will open in a new tab. If it doesn\'t, please check your browser settings.'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error opening CV: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
