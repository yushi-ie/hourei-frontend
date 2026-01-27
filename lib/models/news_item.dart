import 'discussion.dart';

class NewsItem {
  final dynamic id; // Can be int or String
  final String title;
  final String summary;
  final String? imageUrl;
  final List<String> relatedLaws;
  final List<Discussion> relatedDiscussions;

  /// Returns the image URL proxied through weserv.nl to bypass CORS restrictions.
  /// This is necessary for Flutter Web (CanvasKit) which triggers CORS preflight checks.
  String? get proxyImageUrl {
    if (imageUrl == null || imageUrl!.isEmpty) return null;
    // Encode the URL for use as a query parameter
    final encodedUrl = Uri.encodeComponent(imageUrl!);
    return 'https://images.weserv.nl/?url=$encodedUrl&w=600&h=400&fit=cover&output=webp';
  }

  NewsItem({
    required this.id,
    required this.title,
    required this.summary,
    this.imageUrl,
    required this.relatedLaws,
    this.relatedDiscussions = const [],
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      id: json['id'],
      title: json['title'] ?? '',
      summary: json['summary'] ?? '',
      imageUrl: json['image_url'],
      relatedLaws: (json['related_laws'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      relatedDiscussions: (json['related_discussions'] as List<dynamic>?)
              ?.map((e) => Discussion.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'summary': summary,
      'image_url': imageUrl,
      'related_laws': relatedLaws,
      'related_discussions':
          relatedDiscussions.map((e) => e.toJson()).toList(),
    };
  }
}
