import 'package:flutter/material.dart';
import '../models/discussion.dart';
import 'comment_item.dart';

class DiscussionDetailPanel extends StatefulWidget {
  final Discussion discussion;
  final VoidCallback onBack;

  const DiscussionDetailPanel({
    super.key,
    required this.discussion,
    required this.onBack,
  });

  @override
  State<DiscussionDetailPanel> createState() => _DiscussionDetailPanelState();
}

class _DiscussionDetailPanelState extends State<DiscussionDetailPanel> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submitComment() {
    if (_commentController.text.trim().isEmpty) return;
    
    // TODO: Implement actual comment submission logic
    // For now, just clear the text field
    _commentController.clear();
    
    // Show a snackbar as feedback
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('コメントが送信されました'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF4A9EFF),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E1E1E), // Ensure background match
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side: Thread Detail
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: Color(0xFF2E2E2E), width: 1),
                ),
              ),
              child: Column(
                children: [
                  // Header with back button, title, and tag
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xFF2E2E2E), width: 1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back, color: Colors.white), // Match screenshot white arrow
                              onPressed: widget.onBack,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                widget.discussion.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20, // Slightly larger
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              widget.discussion.date,
                              style: const TextStyle(
                                color: Color(0xFFACACAC),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF252830), // Darker tag bg
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            widget.discussion.lawTitle,
                            style: const TextStyle(
                              color: Color(0xFFACACAC), // Muted text
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Comments list
                  Expanded(
                    child: widget.discussion.comments.isEmpty
                        ? const Center(
                            child: Text(
                              'まだコメントがありません',
                              style: TextStyle(
                                color: Color(0xFFACACAC),
                                fontSize: 14,
                              ),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(24),
                            itemCount: widget.discussion.comments.length,
                            itemBuilder: (context, index) {
                              return CommentItem(
                                comment: widget.discussion.comments[index],
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),

          // Right Side: Comment Input
          Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFF0F1115), // Darker background for right side as per screenshot
              padding: const EdgeInsets.all(48), // Generous padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '議論に参加',
                    style: TextStyle(
                      color: Color(0xFFACACAC), // Muted title similar to screenshot
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '意見を書きましょう',
                    style: TextStyle(
                      color: Color(0xFF6E6E6E),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Input Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF16181D), // Slightly lighter card bg
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF2E2E2E)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                         // User ID place holder
                         const Text(
                          'UserIDxxxxxx',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                         ),
                         const SizedBox(height: 16),
                        TextField(
                          controller: _commentController,
                          maxLines: 10, // Taller input
                          style: const TextStyle(
                            color: Colors.black87, // Dark text on light bg
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            hintText: '書き込み内容',
                            hintStyle: const TextStyle(
                              color: Color(0xFF6E6E6E),
                              fontSize: 14,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFE0E0E0), // Light gray input field
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.all(16),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _submitComment,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3B3B98), // Indigo/Purple accent
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: const Text(
                              '書き込む',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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
    );
  }
}
