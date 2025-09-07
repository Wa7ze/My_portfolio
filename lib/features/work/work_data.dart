class WorkItem {
  final String slug;
  final String title;
  final String imageUrl;
  final String summary;
  final List<String> tags;

  WorkItem({required this.slug, required this.title, required this.imageUrl, required this.summary, required this.tags});
}

final workItems = <WorkItem>[
  WorkItem(
    slug: 'interactive-portfolio',
    title: 'Interactive Portfolio',
    imageUrl: 'https://picsum.photos/seed/p1/1200/800',
    summary: 'A Flutter web portfolio with rich animations.',
    tags: ['Flutter', 'Web', 'Animation'],
  ),
  WorkItem(
    slug: 'brand-landing',
    title: 'Brand Landing',
    imageUrl: 'https://picsum.photos/seed/p2/1200/800',
    summary: 'High-conversion landing page with motion.',
    tags: ['UX', 'Motion', 'Web'],
  ),
  WorkItem(
    slug: 'dataviz-lab',
    title: 'Dataviz Lab',
    imageUrl: 'https://picsum.photos/seed/p3/1200/800',
    summary: 'Explorable charts & micro-interactions.',
    tags: ['Charts', 'Interaction'],
  ),
];
