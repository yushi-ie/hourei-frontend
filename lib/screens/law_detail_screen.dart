import 'package:flutter/material.dart';
import '../models/law.dart';
import '../services/api_service.dart';

class LawDetailScreen extends StatefulWidget {
  final String lawId;
  final String lawTitle;

  const LawDetailScreen({
    super.key,
    required this.lawId,
    required this.lawTitle,
  });

  @override
  State<LawDetailScreen> createState() => _LawDetailScreenState();
}

class _LawDetailScreenState extends State<LawDetailScreen> {
  final ApiService _api = ApiService();
  late Future<LawDetail> _lawDetailFuture;

  @override
  void initState() {
    super.initState();
    _lawDetailFuture = _api.getLawDetail(widget.lawId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lawTitle),
      ),
      body: FutureBuilder<LawDetail>(
        future: _lawDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('エラー: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('データが見つかりません'));
          }

          final detail = snapshot.data!;
          
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.blue.withOpacity(0.05),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("法令番号: ${detail.lawNum}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 4),
                    Text("公布日: ${detail.promulgationDate}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: detail.articles.length,
                  itemBuilder: (context, index) {
                    final article = detail.articles[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.articleNum,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.blueGrey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            article.articleText,
                            style: const TextStyle(
                              fontSize: 15,
                              height: 1.6,
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
