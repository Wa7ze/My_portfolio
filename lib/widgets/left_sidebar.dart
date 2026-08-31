import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../core/app_state.dart';
import '../core/strings/app_strings.dart';

class LeftSidebar extends StatelessWidget {
  final String currentPage;

  const LeftSidebar({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    final theme = Theme.of(context);
    final sidebar = context.read<SidebarController>();
    final themeController = context.watch<ThemeController>();
    final localeController = context.watch<LocaleController>();

    void navigate(String path) {
      sidebar.close();
      context.go(path);
    }

    return Material(
      color: theme.cardColor,
      elevation: 24,
      shadowColor: Colors.black.withOpacity(0.4),
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top padding clears the persistent hamburger/close button that
            // floats above this panel at the same start/top corner.
            const SizedBox(height: 72),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () => navigate('/'),
                child: Text(
                  'Mazen Matran',
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _NavItem(label: strings.navHome, isActive: currentPage == 'home', onTap: () => navigate('/')),
                  _NavItem(label: strings.navAbout, isActive: currentPage == 'about', onTap: () => navigate('/about')),
                  _NavItem(label: strings.navWork, isActive: currentPage == 'work', onTap: () => navigate('/work')),
                  _NavItem(label: strings.navContact, isActive: currentPage == 'contact', onTap: () => navigate('/contact')),
                ],
              ),
            ),
            const Spacer(),
            Divider(color: theme.dividerColor, height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 12, 16),
              child: Row(
                children: [
                  Icon(themeController.isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      themeController.isDark ? strings.sidebarThemeDark : strings.sidebarThemeLight,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  Switch(
                    value: themeController.isDark,
                    onChanged: (_) => themeController.toggle(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                children: [
                  Icon(Icons.language, size: 20, color: theme.iconTheme.color),
                  const SizedBox(width: 12),
                  Text(strings.sidebarLanguage, style: theme.textTheme.bodyMedium),
                  const Spacer(),
                  _LanguagePill(
                    label: 'EN',
                    isActive: localeController.locale.languageCode == 'en',
                    onTap: () => localeController.setLocale(const Locale('en')),
                  ),
                  const SizedBox(width: 8),
                  _LanguagePill(
                    label: 'AR',
                    isActive: localeController.locale.languageCode == 'ar',
                    onTap: () => localeController.setLocale(const Locale('ar')),
                  ),
                ],
              ),
            ),
            Divider(color: theme.dividerColor, height: 1),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '© ${DateTime.now().year} ${strings.footerRights}',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    strings.footerBuiltWith,
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguagePill extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  const _LanguagePill({required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isActive ? theme.colorScheme.primary : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: isActive ? theme.colorScheme.onPrimary : theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  const _NavItem({required this.label, required this.onTap, required this.isActive});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: widget.isActive
                ? theme.colorScheme.primary.withOpacity(0.15)
                : _isHovered
                    ? theme.colorScheme.onSurface.withOpacity(0.06)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: widget.isActive ? Border.all(color: theme.colorScheme.primary.withOpacity(0.4)) : null,
          ),
          child: Text(
            widget.label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: widget.isActive ? FontWeight.w700 : FontWeight.w500,
              color: widget.isActive ? theme.colorScheme.primary : theme.colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
