class CertificateData {
  final String title;
  final String issuer;
  final String date;
  final String? imageAsset;
  final String? url;

  const CertificateData({
    required this.title,
    required this.issuer,
    required this.date,
    this.imageAsset,
    this.url,
  });
}

/// Formal degrees and professional registration — shown first, ahead of
/// courses/internships, with a divider separating the two groups.
final featuredCertificates = <CertificateData>[
  const CertificateData(
    title: "Bachelor's Degree — Software Engineering",
    issuer: 'Üsküdar University — Faculty of Engineering and Natural Sciences',
    date: 'Graduated October 24, 2025 · Diploma No. 02-03548',
    imageAsset: 'assets/images/certificates/0_bachelors.jpg',
  ),
  const CertificateData(
    title: 'Minor Degree — Computer Engineering',
    issuer: 'Üsküdar University — Faculty of Engineering and Natural Sciences',
    date: 'October 31, 2025 · Certificate No. 3603',
    imageAsset: 'assets/images/certificates/1_minor.jpg',
  ),
  const CertificateData(
    title: 'Registered Software Engineer',
    issuer: 'Saudi Council of Engineers (SCE) — Membership ID 1245821',
    date: 'Valid May 2026 – May 2027',
    imageAsset: 'assets/images/certificates/7_sce_registration.jpg',
  ),
];

/// Courses, internships, and program completions.
final certificates = <CertificateData>[
  const CertificateData(
    title: 'AI Training Hackathon',
    issuer: 'Kanz (HumanityAI)',
    date: 'July 15, 2026',
    imageAsset: 'assets/images/certificates/2_kanz_hackathon.jpg',
    url: 'https://try.ka.nz/certificate/KANZ-ATT-442AA89710?certificate_type=participation&recipient_name=Mazen+Matran&issue_date=July+15%2C+2026&certificate_id=KANZ-ATT-442AA89710',
  ),
  const CertificateData(
    title: '"Artificial Intelligence with Cloud & Cybersecurity" Internship Program',
    issuer: 'EARTech Information Technology',
    date: 'October 8, 2025',
    imageAsset: 'assets/images/certificates/3_eartech_coding.jpg',
    url: 'https://credsverse.com/credentials/5f6cbab5-3e19-40a4-b003-caf0e029dc17?preview=1',
  ),
  const CertificateData(
    title: '"Artificial Intelligence with Coding & Cybersecurity" Internship Program',
    issuer: 'EARTech Information Technology',
    date: 'September 17, 2025',
    imageAsset: 'assets/images/certificates/3_eartech_coding.jpg',
    url: 'https://credsverse.com/credentials/21dd3325-670f-4f22-8995-f58b38670e5d?preview=1',
  ),
  const CertificateData(
    title: 'Elements of AI',
    issuer: 'MinnaLearn — Tech Pathways MENA Program (Village Capital × MinnaLearn / University of Helsinki, supported by Google.org)',
    date: 'January 2026',
    imageAsset: 'assets/images/certificates/4_minnalearn.jpg',
  ),
  const CertificateData(
    title: 'Full Stack Development Internship',
    issuer: 'Codveda Technologies',
    date: 'November – December 2025',
    imageAsset: 'assets/images/certificates/5_codveda.jpg',
  ),
  const CertificateData(
    title: 'High Honor Certificate (Yüksek Onur Belgesi)',
    issuer: 'Üsküdar University — awarded for graduating academic distinction',
    date: '2024–2025 Academic Year',
    imageAsset: 'assets/images/certificates/6_ueskuedar_honor.jpg',
  ),
];
