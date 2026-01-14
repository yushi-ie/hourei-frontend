class Discussion {
  final int id;
  final String title;
  final String lawTitle;
  final String date;

  Discussion({
    required this.id,
    required this.title,
    required this.lawTitle,
    required this.date,
  });

  factory Discussion.fromJson(Map<String, dynamic> json) {
    return Discussion(
      id: json['id'],
      title: json['title'],
      lawTitle: json['law_title'] ?? '',
      date: json['created_at'] ?? '',
    );
  }
}
