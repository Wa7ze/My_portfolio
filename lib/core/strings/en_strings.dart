import 'app_strings.dart';

class EnStrings extends AppStrings {
  const EnStrings();

  @override
  String get navHome => 'Home';
  @override
  String get navAbout => 'About';
  @override
  String get navWork => 'My Work';
  @override
  String get navContact => 'Get in touch';
  @override
  String get sidebarThemeLight => 'Light mode';
  @override
  String get sidebarThemeDark => 'Dark mode';
  @override
  String get sidebarLanguage => 'Language';
  @override
  String get openMenu => 'Open menu';
  @override
  String get closeMenu => 'Close menu';
  @override
  String get footerRights => 'Mazen Matran. All rights reserved.';
  @override
  String get footerBuiltWith => 'Built with Flutter';

  @override
  String get heroTitle => 'Software Engineer';
  @override
  String get heroSubtitle => 'Building innovative solutions with Flutter, Python, and AI.';
  @override
  String get heroCtaWork => 'See My Work';
  @override
  String get heroCtaContact => 'Get in touch';
  @override
  String get aboutTeaserTitle => 'About Me';
  @override
  String get aboutTeaserBody =>
      "I'm a software engineer specializing in full-stack development and IT/ERP systems — currently building "
      "production tools used by hundreds of people every day. I'm open to full-time, part-time, or traineeship "
      "opportunities in web, app, or game development.";
  @override
  String get aboutTeaserCta => 'Read my full story';

  @override
  String get aboutPageTitle => 'About';
  @override
  String get aboutPageSubtitle => 'My background, experience, and skills.';
  @override
  String get summaryTitle => 'Professional Summary';
  @override
  String get summaryBody =>
      'Software Engineer with hands-on experience in full-stack development (Python/FastAPI, React, TypeScript, '
      'PostgreSQL) and IT support/ERP administration. Built and deployed a production helpdesk and inventory system '
      'used daily by ~300 users. Experienced with Odoo ERP customization, REST API development, and end-to-end '
      'project delivery from data modeling to UI. Fluent in English and Arabic; advanced Turkish.';
  @override
  String get experienceTitle => 'Work Experience';
  @override
  String get experienceRole => 'IT Support Specialist';
  @override
  String get experienceCompany => 'Alessa Industries — Riyadh, Saudi Arabia';
  @override
  String get experiencePeriod => '2025 – Present';
  @override
  List<String> get experienceBullets => const [
        'Provided first-line IT support to employees using UltraVNC Viewer, resolving hardware, software, and system issues.',
        'Handled Helpdesk requests, troubleshooting Windows OS, applications, network connectivity, and printers.',
        'Participated in ERP system setup and migration activities, including master data preparation, validation, and '
            'testing across Sales, Purchase, Inventory, and Accounting modules.',
        'Developed and maintained custom Odoo modules, handling end-to-end implementation including business logic, '
            'data models, and UI views to extend core ERP functionality.',
      ];
  @override
  String get educationTitle => 'Education';
  @override
  List<EducationEntry> get educationEntries => const [
        EducationEntry(
          degree: "Bachelor's Degree",
          field: 'Software Engineering',
          school: 'Üsküdar University — Istanbul, Turkey',
          gpa: 'GPA: 3.65 / 4.0',
          period: '2021 – 2025',
        ),
        EducationEntry(
          degree: 'Minor Degree',
          field: 'Computer Engineering',
          school: 'Üsküdar University — Istanbul, Turkey',
          gpa: 'GPA: 3.00 / 4.0',
          period: '2022 – 2025',
        ),
      ];
  @override
  String get skillsTitle => 'Technical Skills';
  @override
  Map<String, List<String>> get skillGroups => const {
        'Languages & Frameworks': ['Python', 'Django', 'FastAPI', 'PHP (Laravel)', 'Dart (Flutter)', 'C++', 'C#', 'Java', 'TypeScript', 'HTML'],
        'Web & Data': ['React', 'REST API Development', 'PostgreSQL', 'MySQL', 'SQLite', 'TensorFlow'],
        'Tools & Platforms': ['Git', 'GitHub', 'Microsoft Azure', 'Linux', 'Kali Linux', 'Figma', 'Unity', 'Odoo ERP', 'UltraVNC'],
        'Soft Skills': ['Leadership', 'Cross-functional Communication', 'Problem Solving', 'Critical Thinking', 'Time Management', 'Teamwork'],
      };
  @override
  String get languagesTitle => 'Languages';
  @override
  List<LanguageEntry> get languageEntries => const [
        LanguageEntry(name: 'English', level: 'Fluent'),
        LanguageEntry(name: 'Arabic', level: 'Fluent'),
        LanguageEntry(name: 'Turkish', level: 'Advanced'),
      ];
  @override
  String get certificatesTitle => 'Certificates & Achievements';
  @override
  String get certificatesSubtitle => 'Courses, internships, and programs I have completed.';
  @override
  String get otherCertificatesLabel => 'Courses & Internships';
  @override
  String get verificationLinkLabel => 'Open Verification Link';

  @override
  String get workPageTitle => 'My Work';
  @override
  String get workPageSubtitle => 'Case studies & selected projects.';
  @override
  String get backToProjects => 'Back to Projects';
  @override
  String get projectOverview => 'Project Overview';
  @override
  String get projectGallery => 'Project Gallery';
  @override
  String get viewOnGithub => 'View on GitHub';

  @override
  String get contactTitle => 'Get In Touch';
  @override
  String get contactSubtitle =>
      "I'm always open to discussing new opportunities, collaborations, or just having a chat about technology and coding.";
  @override
  String get contactEmailLabel => 'Email';
  @override
  String get contactPhoneLabel => 'Phone';
  @override
  String get contactLinkedinLabel => 'LinkedIn';
  @override
  String get contactGithubLabel => 'GitHub';
  @override
  String get downloadCvTitle => 'Download My CV';
  @override
  String get downloadCvButton => 'Download Full CV';
}
