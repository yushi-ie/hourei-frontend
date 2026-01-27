import 'package:flutter/material.dart';

class DiscussionCard extends StatelessWidget {
  final String title;
  final String timeAgo;
  final String tag;

  const DiscussionCard({
    super.key,
    required this.title,
    required this.timeAgo,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2129),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF2E2E2E)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              if (timeAgo.isNotEmpty) ...[
                const SizedBox(width: 16),
                Text(
                  timeAgo,
                  style: const TextStyle(
                    color: Color(0xFFACACAC),
                    fontSize: 14,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF252830),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              tag,
              style: const TextStyle(
                color: Color(0xFFACACAC),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
