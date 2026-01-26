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
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: Color(0xFF2E2E2E), width: 1),
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
                      icon: const Icon(Icons.arrow_back, color: Color(0xFF4A9EFF)),
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
                          fontSize: 18,
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
                    color: const Color(0xFF252830),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.discussion.lawTitle,
                    style: const TextStyle(
                      color: Color(0xFFACACAC),
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
                    itemCount: widget.discussion.comments.length,
                    itemBuilder: (context, index) {
                      return CommentItem(
                        comment: widget.discussion.comments[index],
                      );
                    },
                  ),
          ),
          
          // Comment input area
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFF2E2E2E), width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '議論に参加',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '意見を書きましょう',
                  style: TextStyle(
                    color: Color(0xFFACACAC),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _commentController,
                  maxLines: 5,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText: '意見を記入内容',
                    hintStyle: const TextStyle(
                      color: Color(0xFF6E6E6E),
                      fontSize: 14,
                    ),
                    filled: true,
                    fillColor: const Color(0xFF252830),
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
                      backgroundColor: const Color(0xFF4A9EFF),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text(
                      '意見送る',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
