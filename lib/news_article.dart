class NewsArticle {
  final String title;
  final String description;
  final String imageUrl;
  final String content;
  final String url; // Add the URL field

  NewsArticle({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.content,
    required this.url, // Initialize the URL field
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
      content: json['content'] ?? 'No content available',
      url: json['url'] ?? '', // Map 'url' from API
    );
  }
}
