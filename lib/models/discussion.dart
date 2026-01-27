import 'comment.dart';

class Discussion {
  final int id;
  final String title;
  final String lawTitle;
  final String date;
  final List<Comment> comments;

  Discussion({
    required this.id,
    required this.title,
    required this.lawTitle,
    required this.date,
    this.comments = const [],
  });

  factory Discussion.fromJson(Map<String, dynamic> json) {
    return Discussion(
      id: json['id'],
      title: json['title'],
      lawTitle: json['law_title'] ?? '',
      date: json['created_at'] ?? '',
      comments: (json['comments'] as List<dynamic>?)
              ?.map((c) => Comment.fromJson(c))
              .toList() ??
          [],
    );
  }
}
