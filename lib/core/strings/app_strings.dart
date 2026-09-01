import 'package:flutter/material.dart';
import 'en_strings.dart';
import 'ar_strings.dart';

class EducationEntry {
  final String degree;
  final String field;
  final String school;
  final String gpa;
  final String period;
  const EducationEntry({
    required this.degree,
    required this.field,
    required this.school,
    required this.gpa,
    required this.period,
  });
}

class LanguageEntry {
  final String name;
  final String level;
  const LanguageEntry({required this.name, required this.level});
}

/// All UI copy the app needs, in one place per locale. Hand-rolled instead of
/// arb/gen-l10n since the string set is moderate and needs full manual
/// Arabic translation regardless.
abstract class AppStrings {
  const AppStrings();

  // Nav / shell
  String get navHome;
  String get navAbout;
  String get navWork;
  String get navContact;
  String get sidebarThemeLight;
  String get sidebarThemeDark;
  String get sidebarLanguage;
  String get openMenu;
  String get closeMenu;
  String get footerRights;
  String get footerBuiltWith;

  // Home
  String get heroTitle;
  String get heroSubtitle;
  String get heroCtaWork;
  String get heroCtaContact;
  String get aboutTeaserTitle;
  String get aboutTeaserBody;
  String get aboutTeaserCta;

  // About
  String get aboutPageTitle;
  String get aboutPageSubtitle;
  String get summaryTitle;
  String get summaryBody;
  String get experienceTitle;
  String get experienceRole;
  String get experienceCompany;
  String get experiencePeriod;
  List<String> get experienceBullets;
  String get educationTitle;
  List<EducationEntry> get educationEntries;
  String get skillsTitle;
  Map<String, List<String>> get skillGroups;
  String get languagesTitle;
  List<LanguageEntry> get languageEntries;
  String get certificatesTitle;
  String get certificatesSubtitle;
  String get otherCertificatesLabel;
  String get verificationLinkLabel;
  String get cvSectionTitle;
  String get cvSectionSubtitle;

  // Work
  String get workPageTitle;
  String get workPageSubtitle;
  String get backToProjects;
  String get projectOverview;
  String get projectGallery;
  String get viewOnGithub;

  // Contact
  String get contactTitle;
  String get contactSubtitle;
  String get contactEmailLabel;
  String get contactPhoneLabel;
  String get contactLinkedinLabel;
  String get contactGithubLabel;
  String get downloadCvTitle;
  String get downloadCvButton;
}

extension AppStringsX on BuildContext {
  AppStrings get strings =>
      Localizations.localeOf(this).languageCode == 'ar' ? const ArStrings() : const EnStrings();
}
