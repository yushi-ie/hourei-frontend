import 'package:flutter/material.dart';

class NewsDetailPanel extends StatelessWidget {
  final Map<String, dynamic> newsItem;
  final VoidCallback onBack;

  const NewsDetailPanel({
    super.key,
    required this.newsItem,
    required this.onBack,
  });

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
                          onPressed: onBack,
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
                        child: const Icon(Icons.image,
                            color: Colors.white24, size: 64),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Title and Date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            newsItem['title'] ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                         Text(
                          // Using a fixed format for now or parsing if needed, assumed item has a date or reusing timeAgo
                          // For design match, using a placeholder format if date isn't in item
                          '2026-01-01 18:00', 
                          style: const TextStyle(
                            color: Color(0xFFACACAC),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Description
                    Text(
                      newsItem['description'] ?? '',
                      style: const TextStyle(
                        color: Color(0xFFACACAC),
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Long text repetition for visual match (as requested by user "images's UI")
                    const Text(
                      '物流クライシスへの対応として、ドローンによる市街地配送の規制が緩和される見通しです。\n'
                      '〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜\n'
                      '〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜\n'
                      '〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜\n'
                      '〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜',
                      style: TextStyle(
                        color: Color(0xFFACACAC),
                        fontSize: 14,
                        height: 1.6,
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
                     color: const Color(0xFF16181D), // Darker background for box
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
                      // Buttons
                      _buildLawButton('交通法'),
                      const SizedBox(height: 12),
                      _buildLawButton('刑法施行法'),
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
        onPressed: () {},
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF8C9CAB),
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
