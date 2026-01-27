import 'package:flutter/material.dart';
import '../widgets/news_detail_panel.dart';
import '../services/api_service.dart';
import '../models/news_item.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final ApiService _api = ApiService();
  NewsItem? _selectedNewsItem;
  List<NewsItem> _newsItems = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  Future<void> _loadNews() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final news = await _api.getNews();
      setState(() {
        _newsItems = news;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'ニュースの取得に失敗しました: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E2129),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('ニュース・時事ネタ'),
          ],
        ),
        titleTextStyle: const TextStyle(color: Color(0xFFACACAC), fontSize: 15),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFF2E2E2E),
          ),
        ),
      ),
      body: _selectedNewsItem != null
          ? NewsDetailPanel(
              newsItem: _selectedNewsItem!,
              onBack: () {
                setState(() {
                  _selectedNewsItem = null;
                });
              },
            )
          : _isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF3F3B96),
                  ),
                )
              : _errorMessage != null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Color(0xFFACACAC),
                            size: 48,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _errorMessage!,
                            style: const TextStyle(
                              color: Color(0xFFACACAC),
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _loadNews,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3F3B96),
                            ),
                            child: const Text(
                              '再試行',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Row(
                      children: [
                        // Left Panel: News List
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  '最新のニュースを表示しています',
                                  style: TextStyle(
                                    color: Color(0xFFACACAC),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Left Column
                                      Expanded(
                                        child: Column(
                                          children: [
                                            for (int i = 0; i < _newsItems.length; i += 2)
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 16.0),
                                                child: _buildNewsCard(_newsItems[i]),
                                              ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      // Right Column
                                      Expanded(
                                        child: Column(
                                          children: [
                                            for (int i = 1; i < _newsItems.length; i += 2)
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 16.0),
                                                child: _buildNewsCard(_newsItems[i]),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Vertical Divider
                        const VerticalDivider(
                          width: 1,
                          thickness: 1,
                          color: Color(0xFF2E2E2E),
                        ),
                        // Right Panel: Detail Placeholder
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'ニュースを選択して詳細を表示',
                                style: TextStyle(
                                  color: Color(0xFFACACAC),
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                '左側のリストから気になるニュースの詳細を\\n確認しましょう',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFACACAC),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
    );
  }

  Widget _buildNewsCard(NewsItem item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedNewsItem = item;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E2129),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF2E2E2E)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Wrap content height
          children: [
            // Image Placeholder (Fixed aspect ratio)
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.grey, // Placeholder color
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                ),
                width: double.infinity,
                child: item.imageUrl != null
                    ? Image.network(
                        item.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.image, color: Colors.white24, size: 48);
                        },
                      )
                    : const Icon(Icons.image, color: Colors.white24, size: 48),
              ),
            ),
            // Content (Variable height)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2, // Limit title lines
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.summary,
                    style: const TextStyle(
                      color: Color(0xFFACACAC),
                      fontSize: 11,
                    ),
                    maxLines: 3, // Limit description lines (e.g., 3 lines max)
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: item.relatedLaws.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E2E2E), // Tag background
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            color: Color(0xFFACACAC), // Tag text
                            fontSize: 10,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
