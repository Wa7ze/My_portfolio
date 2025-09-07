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
  return [
    'images/$projectSlug/1.png',
    'images/$projectSlug/2.png',
    'images/$projectSlug/3.png',
  ];
}

final workItems = <WorkItem>[
  WorkItem(
    slug: 'portfolio-website',
    title: 'Portfolio Website',
    imageUrl: 'images/portfoilo-website/1.png',
    summary: 'A responsive Flutter web portfolio showcasing my skills, projects, and professional journey with smooth animations and modern design.',
    tags: ['Flutter', 'Web', 'Animation', 'Responsive Design'],
    githubUrl: 'https://github.com/Wa7ze/mazen_portfolio',
    galleryImages: getProjectImages('portfoilo-website'),
    overview: 'This portfolio website represents my journey as a software engineer, built entirely with Flutter for web. It features a modern, responsive design with smooth animations and interactive elements. The site showcases my projects, skills, and professional experience in an engaging way. Built with a focus on performance and user experience, it demonstrates my expertise in Flutter development and modern web technologies.',
  ),
  WorkItem(
    slug: 'outfitly-app',
    title: 'Outfitly App',
    imageUrl: 'images/outfitly-app/1.png',
    summary: 'AI-powered fashion companion that revolutionizes wardrobe management with smart outfit recommendations and real-time style feedback.',
    tags: ['Flutter', 'AI/ML', 'TensorFlow', 'Mobile App'],
    githubUrl: 'https://github.com/Wa7ze/outfitly-3',
    galleryImages: getProjectImages('outfitly-app'),
    overview: 'Outfitly is my graduation project - an innovative AI-powered fashion companion that transforms how people manage their wardrobes. The app uses machine learning algorithms to analyze clothing items and generate personalized outfit recommendations. Built with Flutter for cross-platform compatibility and integrated with TensorFlow for AI capabilities, it provides users with real-time style feedback and smart wardrobe organization. The project demonstrates my expertise in mobile development, AI integration, and user experience design.',
  ),
  WorkItem(
    slug: 'nutritrack-website',
    title: 'Nutritrack Website',
    imageUrl: 'images/nutritrack-website/1.png',
    summary: 'Social-based nutrition tracking website built with Django, featuring user authentication, meal logging, and community features.',
    tags: ['Python', 'Django', 'MySQL', 'Social Features'],
    githubUrl: 'https://github.com/Wa7ze/nutritrack',
    galleryImages: getProjectImages('nutritrack-website'),
    overview: 'Nutritrack is a comprehensive social nutrition tracking platform that combines health monitoring with community engagement. Built using Django and Python, the website features robust user authentication, detailed meal logging, and social sharing capabilities. I implemented the login/logout system and comprehensive testing using Eclipse and Apache JMeter. The platform allows users to track their nutritional intake, share meals with the community, and receive personalized health insights. This project showcases my backend development skills and understanding of social web applications.',
  ),
  WorkItem(
    slug: 'clubconnect-website',
    title: 'ClubConnect Website',
    imageUrl: 'images/clubconnect-website/1.png',
    summary: 'Platform designed to simplify access to member benefits, offering movie ticketing, fuel discounts, and exclusive member offers.',
    tags: ['Web Development', 'Member Management', 'E-commerce'],
    githubUrl: 'https://github.com/Wa7ze/clubconnect',
    galleryImages: getProjectImages('clubconnect-website'),
    overview: 'ClubConnect is a comprehensive member benefits platform designed to streamline access to exclusive offers and services. The website provides members with easy access to movie ticketing, fuel discounts, car parking, and various other benefits. Built with modern web technologies, it features an intuitive user interface and robust backend systems for managing member accounts and benefit distribution. The platform enhances member engagement by providing a centralized hub for all club-related services and exclusive offers. This project demonstrates my skills in full-stack web development and user experience optimization.',
  ),
  WorkItem(
    slug: 'eary-woods-game',
    title: 'Eary Woods Game',
    imageUrl: 'images/eary-woods-game/1.png',
    summary: 'Horror roll-a-ball game developed in Unity with custom enemy AI, input controls, and immersive gameplay mechanics.',
    tags: ['Unity', 'C#', 'Game Development', 'AI'],
    githubUrl: 'https://github.com/Wa7ze/eary-woods',
    galleryImages: getProjectImages('eary-woods-game'),
    overview: 'Eary Woods is a thrilling horror roll-a-ball game that showcases my game development skills and creativity. Developed in Unity using C#, this project features custom enemy AI systems, responsive input controls, and immersive gameplay mechanics. I was responsible for coding most of the game logic, including player movement, enemy behavior, and level design modifications. The game creates an atmospheric horror experience with challenging gameplay and engaging mechanics. This project demonstrates my proficiency in Unity development, C# programming, and game design principles, highlighting my ability to create engaging interactive experiences.',
  ),
];
