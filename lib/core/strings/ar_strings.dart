import 'app_strings.dart';

class ArStrings extends AppStrings {
  const ArStrings();

  @override
  String get navHome => 'الرئيسية';
  @override
  String get navAbout => 'نبذة عني';
  @override
  String get navWork => 'أعمالي';
  @override
  String get navContact => 'تواصل معي';
  @override
  String get sidebarThemeLight => 'الوضع الفاتح';
  @override
  String get sidebarThemeDark => 'الوضع الداكن';
  @override
  String get sidebarLanguage => 'اللغة';
  @override
  String get openMenu => 'فتح القائمة';
  @override
  String get closeMenu => 'إغلاق القائمة';
  @override
  String get footerRights => 'مازن مطران. جميع الحقوق محفوظة.';
  @override
  String get footerBuiltWith => 'صُنع باستخدام Flutter';

  @override
  String get heroTitle => 'مهندس برمجيات';
  @override
  String get heroSubtitle => 'أبني حلولاً مبتكرة باستخدام Flutter وPython والذكاء الاصطناعي.';
  @override
  String get heroCtaWork => 'شاهد أعمالي';
  @override
  String get heroCtaContact => 'تواصل معي';
  @override
  String get aboutTeaserTitle => 'نبذة عني';
  @override
  String get aboutTeaserBody =>
      'أنا مهندس برمجيات متخصص في تطوير البرمجيات المتكاملة (Full-Stack) وأنظمة تقنية المعلومات وERP، '
      'أعمل حاليًا على بناء أدوات إنتاجية يستخدمها المئات يوميًا. أنا منفتح على فرص العمل بدوام كامل أو جزئي '
      'أو التدريب في مجالات تطوير الويب والتطبيقات وتطوير الألعاب.';
  @override
  String get aboutTeaserCta => 'اقرأ قصتي كاملة';

  @override
  String get aboutPageTitle => 'نبذة عني';
  @override
  String get aboutPageSubtitle => 'خلفيتي المهنية وخبراتي ومهاراتي.';
  @override
  String get summaryTitle => 'الملخص المهني';
  @override
  String get summaryBody =>
      'مهندس برمجيات يتمتع بخبرة عملية في تطوير البرمجيات المتكاملة (Full-Stack) باستخدام Python/FastAPI وReact '
      'وTypeScript وPostgreSQL، إضافة إلى الدعم الفني وإدارة أنظمة تخطيط موارد المؤسسات (ERP). قام ببناء ونشر نظام '
      'إنتاجي لإدارة طلبات الدعم الفني والمخزون يُستخدم يوميًا من قبل نحو 300 مستخدم. لديه خبرة في تخصيص نظام '
      'Odoo ERP، وتطوير واجهات REST API، وتسليم المشاريع من مرحلة نمذجة البيانات وحتى واجهة المستخدم. يجيد '
      'اللغتين الإنجليزية والعربية بطلاقة، ولديه مستوى متقدم في اللغة التركية.';
  @override
  String get experienceTitle => 'الخبرة العملية';
  @override
  String get experienceRole => 'أخصائي دعم فني';
  @override
  String get experienceCompany => 'شركة Alessa Industries — الرياض، المملكة العربية السعودية';
  @override
  String get experiencePeriod => '2025 – حتى الآن';
  @override
  List<String> get experienceBullets => const [
        'تقديم الدعم الفني المباشر للموظفين باستخدام برنامج UltraVNC Viewer، وحل مشكلات الأجهزة والبرمجيات والأنظمة.',
        'التعامل مع طلبات الدعم الفني، واستكشاف أخطاء نظام Windows والتطبيقات والاتصال بالشبكة والطابعات وإصلاحها.',
        'المشاركة في إعداد وترحيل نظام ERP، بما في ذلك تجهيز البيانات الأساسية والتحقق منها واختبارها عبر وحدات '
            'المبيعات والمشتريات والمخزون والمحاسبة.',
        'تطوير وصيانة وحدات Odoo المخصصة، والإشراف على التنفيذ الكامل بدءًا من منطق الأعمال ونماذج البيانات وحتى '
            'واجهات المستخدم لتوسيع وظائف نظام ERP الأساسية.',
      ];
  @override
  String get educationTitle => 'التعليم';
  @override
  List<EducationEntry> get educationEntries => const [
        EducationEntry(
          degree: 'درجة البكالوريوس',
          field: 'هندسة البرمجيات',
          school: 'جامعة أسكودار — إسطنبول، تركيا',
          gpa: 'المعدل التراكمي: 3.65 / 4.0',
          period: '2021 – 2025',
        ),
        EducationEntry(
          degree: 'تخصص فرعي',
          field: 'هندسة الحاسوب',
          school: 'جامعة أسكودار — إسطنبول، تركيا',
          gpa: 'المعدل التراكمي: 3.00 / 4.0',
          period: '2022 – 2025',
        ),
      ];
  @override
  String get skillsTitle => 'المهارات التقنية';
  @override
  Map<String, List<String>> get skillGroups => const {
        'لغات البرمجة والأطر': ['Python', 'Django', 'FastAPI', 'PHP (Laravel)', 'Dart (Flutter)', 'C++', 'C#', 'Java', 'TypeScript', 'HTML'],
        'الويب والبيانات': ['React', 'تطوير REST API', 'PostgreSQL', 'MySQL', 'SQLite', 'TensorFlow'],
        'الأدوات والمنصات': ['Git', 'GitHub', 'Microsoft Azure', 'Linux', 'Kali Linux', 'Figma', 'Unity', 'Odoo ERP', 'UltraVNC'],
        'المهارات الشخصية': ['القيادة', 'التواصل بين الفرق', 'حل المشكلات', 'التفكير النقدي', 'إدارة الوقت', 'العمل الجماعي'],
      };
  @override
  String get languagesTitle => 'اللغات';
  @override
  List<LanguageEntry> get languageEntries => const [
        LanguageEntry(name: 'الإنجليزية', level: 'طلاقة'),
        LanguageEntry(name: 'العربية', level: 'طلاقة'),
        LanguageEntry(name: 'التركية', level: 'متقدم'),
      ];
  @override
  String get certificatesTitle => 'الشهادات والإنجازات';
  @override
  String get certificatesSubtitle => 'الدورات والتدريبات والبرامج التي أكملتها.';
  @override
  String get otherCertificatesLabel => 'الدورات والتدريبات';
  @override
  String get verificationLinkLabel => 'فتح رابط التحقق';
  @override
  String get cvSectionTitle => 'السيرة الذاتية';
  @override
  String get cvSectionSubtitle => 'اضغط على المعاينة لعرضها بالحجم الكامل، أو نزّل ملف PDF.';

  @override
  String get workPageTitle => 'أعمالي';
  @override
  String get workPageSubtitle => 'دراسات حالة ومشاريع مختارة.';
  @override
  String get backToProjects => 'العودة إلى المشاريع';
  @override
  String get projectOverview => 'نظرة عامة على المشروع';
  @override
  String get projectGallery => 'معرض الصور';
  @override
  String get viewOnGithub => 'عرض على GitHub';

  @override
  String get contactTitle => 'تواصل معي';
  @override
  String get contactSubtitle =>
      'أنا منفتح دائمًا لمناقشة الفرص الجديدة والتعاون، أو حتى لحديث عام حول التقنية والبرمجة.';
  @override
  String get contactEmailLabel => 'البريد الإلكتروني';
  @override
  String get contactPhoneLabel => 'الهاتف';
  @override
  String get contactLinkedinLabel => 'لينكدإن';
  @override
  String get contactGithubLabel => 'جيت هاب';
  @override
  String get downloadCvTitle => 'تحميل سيرتي الذاتية';
  @override
  String get downloadCvButton => 'تحميل السيرة الذاتية الكاملة';
}
