class LawItem {
  final String lawId;
  final String lawTitle;
  final String lawNum;
  final String category;

  LawItem({
    required this.lawId,
    required this.lawTitle,
    required this.lawNum,
    required this.category,
  });

  factory LawItem.fromJson(Map<String, dynamic> json) {
    return LawItem(
      lawId: json['law_id'] ?? '',
      lawTitle: json['law_title'] ?? '',
      lawNum: json['law_num'] ?? '',
      category: json['category'] ?? '',
    );
  }
}

class LawArticle {
  final String id;
  final String articleNum;
  final String articleText;
  
  LawArticle({
    required this.id,
    required this.articleNum,
    required this.articleText,
  });

  factory LawArticle.fromJson(Map<String, dynamic> json) {
    return LawArticle(
      id: json['id'] ?? '',
      articleNum: json['article_num'] ?? '',
      articleText: json['article_text'] ?? '',
    );
  }
}

class LawDetail {
  final String lawId;
  final String lawTitle;
  final String lawNum;
  final String category;
  final String promulgationDate;
  final List<LawArticle> articles;

  LawDetail({
    required this.lawId,
    required this.lawTitle,
    required this.lawNum,
    required this.category,
    required this.promulgationDate,
    required this.articles,
  });

  factory LawDetail.fromJson(Map<String, dynamic> json) {
    var list = json['articles'] as List? ?? [];
    List<LawArticle> articlesList = list.map((i) => LawArticle.fromJson(i)).toList();

    return LawDetail(
      lawId: json['law_id'] ?? '',
      lawTitle: json['law_title'] ?? '',
      lawNum: json['law_num'] ?? '',
      category: json['category'] ?? '',
      promulgationDate: json['promulgation_date'] ?? '',
      articles: articlesList,
    );
  }
}
