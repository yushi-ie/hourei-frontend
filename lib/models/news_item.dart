import 'discussion.dart';

class NewsItem {
  final dynamic id; // Can be int or String
  final String title;
  final String summary;
  final String? imageUrl;
  final List<String> relatedLaws;
  final List<Discussion> relatedDiscussions;

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
