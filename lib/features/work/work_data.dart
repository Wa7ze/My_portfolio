class WorkItem {
  final String slug;
  final String title;
  final String imageUrl;
  final String summary;
  final List<String> tags;
  final String githubUrl;
  final List<String> galleryImages;
  final String overview;

  WorkItem({
    required this.slug,
    required this.title,
    required this.imageUrl,
    required this.summary,
    required this.tags,
    required this.githubUrl,
    required this.galleryImages,
    required this.overview,
  });
}

// Helper function to get local image paths
List<String> getProjectImages(String projectSlug) {
  if (projectSlug == 'portfoilo-website') {
    return [
      'assets/images/portfoilo-website/image.png',
      'assets/images/portfoilo-website/image copy.png',
      'assets/images/portfoilo-website/image copy 2.png',
    ];
  }
  if (projectSlug == 'helpdesk-system') {
    return [
      'assets/images/helpdesk-system/1.png',
      'assets/images/helpdesk-system/2.png',
      'assets/images/helpdesk-system/3.png',
      'assets/images/helpdesk-system/4.png',
    ];
  }
  return [
    'assets/images/$projectSlug/1.png',
    'assets/images/$projectSlug/2.png',
    'assets/images/$projectSlug/3.png',
  ];
}

final workItems = <WorkItem>[
  WorkItem(
    slug: 'helpdesk-system',
    title: 'Helpdesk & Inventory Management System',
    imageUrl: 'assets/images/helpdesk-system/2.png',
    summary: 'Production FastAPI + React helpdesk and inventory platform serving ~300 daily users, with ticket '
        'approval workflows, device inventory, and activity tracking, built and shipped solo end-to-end.',
    tags: ['Python', 'FastAPI', 'PostgreSQL', 'React', 'TypeScript'],
    githubUrl: 'https://github.com/Wa7ze',
    galleryImages: getProjectImages('helpdesk-system'),
    overview: 'An independent, full-stack helpdesk and inventory system used daily by roughly 300 employees at a real '
        'company. The backend is built with Python and FastAPI on PostgreSQL, exposing a REST API for ticketing, '
        'device/inventory records, and role-based access control, deployed on Render; the frontend is a React + '
        'TypeScript SPA deployed on Netlify. The ticketing module supports full approval workflows (create, edit, '
        'close, and approve requests), the inventory module tracks devices with bulk Excel import, and an activity '
        'log records changes across the system for auditability. This project demonstrates end-to-end ownership of a '
        'production system: API design, relational data modeling, authentication, deployment, and a responsive UI — '
        'all shipped and actively used, not just a demo.',
  ),
  WorkItem(
    slug: 'portfolio-website',
    title: 'Portfolio Website',
    imageUrl: 'assets/images/portfoilo-website/image copy 2.png',
    summary: 'This site: a responsive Flutter web app with a theme system (dark/light), full Arabic/English i18n '
        'with RTL support, and choreographed motion built on Flutter\'s animation and custom-painting APIs.',
    tags: ['Flutter', 'Dart', 'i18n / RTL', 'Custom Animation', 'Responsive Design'],
    githubUrl: 'https://github.com/Wa7ze/My_portfolio',
    galleryImages: getProjectImages('portfoilo-website'),
    overview: 'My portfolio, built entirely in Flutter for web rather than a templated site builder. It implements a '
        'shared light/dark ThemeData pair with a custom ThemeExtension for palette tokens, a hand-rolled Arabic/'
        'English localization layer that drives Flutter\'s Directionality so the entire layout mirrors correctly in '
        'RTL, a Provider-based state layer for theme/locale/navigation state, and a CustomPainter-driven opening '
        'animation. The floating, hamburger-triggered sidebar, staggered scroll-reveal animations, and responsive '
        'grid layouts across every page are all hand-built. The project is a practical showcase of Flutter web '
        'architecture: state management, custom painting, internationalization, and motion design working together.',
  ),
  WorkItem(
    slug: 'outfitly-app',
    title: 'Outfitly App',
    imageUrl: 'assets/images/outfitly-app/1.png',
    summary: 'Cross-platform Flutter wardrobe app with a Django + TensorFlow recommendation backend — my graduation '
        'project, covering mobile UI, API integration, and applied ML end-to-end.',
    tags: ['Flutter', 'Django', 'TensorFlow', 'REST API', 'Mobile App'],
    githubUrl: 'https://github.com/Wa7ze/outfitly-3',
    galleryImages: getProjectImages('outfitly-app'),
    overview: 'Outfitly is my graduation project: an AI-powered wardrobe companion split cleanly between a Flutter '
        'cross-platform client and a Django + TensorFlow backend. The Flutter app handles the digital wardrobe, '
        'outfit planner, and social feed, communicating with the backend over a REST API; the backend uses '
        'TensorFlow models to analyze clothing items and generate personalized outfit recommendations. Building it '
        'meant working across the whole stack — mobile UI/UX in Flutter, API contract design, and integrating a '
        'trained ML model into a real product — which is what made it the strongest demonstration of my range as an '
        'engineer during my degree.',
  ),
  WorkItem(
    slug: 'nutritrack-website',
    title: 'Nutritrack Website',
    imageUrl: 'assets/images/nutritrack-website/1.png',
    summary: 'Django-based social nutrition tracker (~65% individual contribution) — built the authentication system '
        'and validated it with Selenium functional tests and JMeter load tests.',
    tags: ['Python', 'Django', 'SQLite', 'Selenium', 'JMeter'],
    githubUrl: 'https://github.com/Wa7ze/nutritrack',
    galleryImages: getProjectImages('nutritrack-website'),
    overview: 'NutriTrack is a social nutrition-tracking platform built with Django, HTML, and SQLite, where I owned '
        'roughly 65% of the project. My core contribution was the authentication and account system — signup, login, '
        'profile management, and follow/unfollow logic — plus the meal-posting and search features that sit on top '
        'of it. I also designed and ran the test suite: functional test cases in Selenium to verify user flows end '
        'to end, and load/performance testing with Apache JMeter to check the app under concurrent traffic. This '
        'project reflects both backend ownership and a QA mindset — building the feature and proving it works under '
        'load, not just that it compiles.',
  ),
  WorkItem(
    slug: 'clubconnect-website',
    title: 'ClubConnect Website',
    imageUrl: 'assets/images/clubconnect-website/1.png',
    summary: 'Full-stack member benefits platform — account management, benefit redemption, and an admin-facing '
        'backend for a member offers program (ticketing, fuel discounts, parking).',
    tags: ['Full-Stack Web', 'Database Design', 'Member Management'],
    githubUrl: 'https://github.com/Wa7ze/clubconnect',
    galleryImages: getProjectImages('clubconnect-website'),
    overview: 'ClubConnect is a member-benefits platform that centralizes access to movie ticketing, fuel discounts, '
        'parking, and other exclusive offers behind a single member account system. I designed the data model for '
        'members and benefit entitlements, built the backend logic for account management and benefit redemption, '
        "and implemented the front-end views members use to browse and claim offers. The project's focus was on "
        'clean relational data design and a straightforward, reliable user flow — the parts of full-stack '
        'development that matter most for a real membership product, rather than a purely visual exercise.',
  ),
  WorkItem(
    slug: 'eary-woods-game',
    title: 'Eary Woods Game',
    imageUrl: 'assets/images/eary-woods-game/1.png',
    summary: 'Unity horror roll-a-ball game — wrote the C# gameplay systems: player movement/physics, enemy AI '
        'behavior, and level scripting.',
    tags: ['Unity', 'C#', 'Game AI', 'Physics'],
    githubUrl: 'https://github.com/Wa7ze/eary-woods',
    galleryImages: getProjectImages('eary-woods-game'),
    overview: 'Eary Woods is a horror-themed roll-a-ball game built in Unity, where I was responsible for coding '
        'most of the core gameplay in C#: physics-driven player movement and input handling, an enemy AI state '
        'system that drives chase/patrol behavior to create tension, and scripted level logic and triggers. Beyond '
        'gameplay code, I worked on level design adjustments to pace the horror atmosphere correctly. The project is '
        'a concrete demonstration of applied game-engine programming — physics, AI state machines, and player-facing '
        'game feel — rather than just using pre-built Unity assets.',
  ),
];
