class Comment {
  final int id;
  final String userId;
  final String content;
  final DateTime createdAt;
  final int discussionId;

  Comment({
    required this.id,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.discussionId,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      userId: json['user_id'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      discussionId: json['discussion_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'discussion_id': discussionId,
    };
  }
}
