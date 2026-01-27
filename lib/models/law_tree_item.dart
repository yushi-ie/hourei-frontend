class LawTreeItem {
  final String id;
  final String name;
  final String type; // 'category' or 'law'
  final List<LawTreeItem> children;

  LawTreeItem({
    required this.id,
    required this.name,
    required this.type,
    this.children = const [],
  });

  factory LawTreeItem.fromJson(Map<String, dynamic> json) {
    return LawTreeItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? 'law',
      children: (json['children'] as List<dynamic>?)
              ?.map((e) => LawTreeItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'children': children.map((e) => e.toJson()).toList(),
    };
  }

  bool get isCategory => type == 'category';
  bool get isLaw => type == 'law';
}
