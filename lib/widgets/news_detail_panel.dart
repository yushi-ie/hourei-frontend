import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/news_item.dart';
import '../services/api_service.dart';

class NewsDetailPanel extends StatefulWidget {
  final NewsItem newsItem;
  final VoidCallback onBack;
  /// Callback when user taps on a related law to navigate to LawDetailScreen.
  /// Parameters: lawId, lawTitle, searchKeyword (the original label shown on the button)
  final void Function(String lawId, String lawTitle, String searchKeyword)? onNavigateToLaw;

  const NewsDetailPanel({
    super.key,
    required this.newsItem,
    required this.onBack,
    this.onNavigateToLaw,
  });

  @override
  State<NewsDetailPanel> createState() => _NewsDetailPanelState();
}

class _NewsDetailPanelState extends State<NewsDetailPanel> {
  final ApiService _api = ApiService();
  List<String> _relatedLaws = [];
  bool _isLoadingLaws = false;

  @override
  void initState() {
    super.initState();
    _relatedLaws = widget.newsItem.relatedLaws;
    if (_relatedLaws.isEmpty) {
      _analyzeLaws();
    }
  }

  // If the news item changes (e.g. parent updates), re-analyze
  @override
  void didUpdateWidget(NewsDetailPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.newsItem.id != oldWidget.newsItem.id) {
       setState(() {
         _relatedLaws = widget.newsItem.relatedLaws;
       });
       if (_relatedLaws.isEmpty) {
         _analyzeLaws();
       }
    }
  }

  Future<void> _analyzeLaws() async {
    setState(() {
      _isLoadingLaws = true;
    });
    try {
      final laws = await _api.analyzeNews(
        widget.newsItem.title,
        widget.newsItem.summary,
      );
      if (mounted) {
        setState(() {
          _relatedLaws = laws;
          _isLoadingLaws = false;
        });
      }
    } catch (e) {
      print('Error analyzing laws: $e');
      if (mounted) {
        setState(() {
          _isLoadingLaws = false;
        });
      }
    }
  }

  Future<void> _launchURL() async {
    // Attempt to parse ID as URL
    final urlStr = widget.newsItem.id.toString();
    final Uri? url = Uri.tryParse(urlStr);
    
    if (url != null && await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      // Show snackbar or alert if URL is invalid
      if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('リンクを開けませんでした')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Panel: Main Content
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2129),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back Button
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: widget.onBack,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Image
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: widget.newsItem.proxyImageUrl != null
                            ? Image.network(
                                widget.newsItem.proxyImageUrl!,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Color(0xFF3F3B96),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(Icons.image_not_supported,
                                        color: Colors.white24, size: 64),
                                  );
                                },
                              )
                            : const Icon(Icons.image,
                                color: Colors.white24, size: 64),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Title
                    Text(
                      widget.newsItem.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Description
                    Text(
                      widget.newsItem.summary,
                      style: const TextStyle(
                        color: Color(0xFFACACAC),
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Read More Button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: _launchURL,
                        icon: const Icon(Icons.open_in_new, size: 16),
                        label: const Text('続きを読む (提供元記事へ)'),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF5E5CE6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Vertical Divider
        const VerticalDivider(
          width: 1,
          thickness: 1,
          color: Color(0xFF2E2E2E),
        ),
        // Right Panel: Related Info
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 48),
                const Text(
                  'このニュースにおける関連法令を確認しましょう',
                  style: TextStyle(
                    color: Color(0xFFACACAC),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF16181D),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF2E2E2E)),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        '関連法令',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (_isLoadingLaws)
                        const SizedBox(
                          height: 50,
                          child: Center(
                            child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF5E5CE6)),
                          ),
                        )
                      else if (_relatedLaws.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("関連法令は見つかりませんでした",
                              style: TextStyle(color: Color(0xFF8C9CAB), fontSize: 12)),
                        )
                      else
                        ..._relatedLaws.map((law) => Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: _buildLawButton(law),
                            )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLawButton(String label) {
    return SizedBox(
      width: double.infinity,
      height: 36,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF252830),
          side: const BorderSide(color: Color(0xFF2E2E2E)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          elevation: 0,
        ),
        onPressed: () async {
          // Search for the law by name and navigate to it
          if (widget.onNavigateToLaw != null) {
            try {
              // Show loading indicator
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(color: Color(0xFF5E5CE6)),
                ),
              );

              // Search for the law by name
              final result = await _api.searchLaws(label);
              
              // Close loading indicator
              if (mounted) {
                Navigator.of(context).pop();
              }
              
              // Check if we found any results
              if (result.isNotEmpty && result['items'] != null) {
                final items = result['items'] as List;
                if (items.isNotEmpty) {
                  final firstLaw = items[0];
                  final lawId = firstLaw['law_id']?.toString() ?? label;
                  final lawTitle = firstLaw['law_title']?.toString() ?? label;
                  widget.onNavigateToLaw!(lawId, lawTitle, label);
                  return;
                }
              }
              
              // If no results found, use the label as-is
              widget.onNavigateToLaw!(label, label, label);
            } catch (e) {
              // Close loading indicator if open
              if (mounted) {
                Navigator.of(context).pop();
              }
              print('Error searching law: $e');
              // Navigate with the label as fallback
              widget.onNavigateToLaw!(label, label, label);
            }
          } else {
            print('Law clicked: $label (no navigation callback set)');
          }
        },
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF8C9CAB),
            fontSize: 12,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
