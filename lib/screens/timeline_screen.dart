import 'package:flutter/material.dart';
import '../widgets/discussion_card.dart';
import '../widgets/discussion_detail_panel.dart';
import '../models/discussion.dart';
import '../models/comment.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  Discussion? _selectedDiscussion;

  // Dummy data with comments
  final List<Discussion> dummyDiscussions = [
    Discussion(
      id: 1,
      title: '道路交通法の改善について',
      lawTitle: '道路交通法',
      date: '1時間前',
      comments: [
        Comment(
          id: 1,
          userId: 'UserIDxxxxxx',
          content: '道路交通法改善した方が良いと思います。',
          createdAt: DateTime.now().subtract(const Duration(hours: 1)),
          discussionId: 1,
        ),
        Comment(
          id: 2,
          userId: 'UserIDxxxxxx',
          content: '道路交通法改善した方が良いと思いません。',
          createdAt: DateTime.now().subtract(const Duration(hours: 1, minutes: 3)),
          discussionId: 1,
        ),
        Comment(
          id: 3,
          userId: 'UserIDxxxxxx',
          content: '道路交通法改善した方が良いと思いません。',
          createdAt: DateTime.now().subtract(const Duration(hours: 1, minutes: 6)),
          discussionId: 1,
        ),
      ],
    ),
    Discussion(
      id: 2,
      title: '刑法について',
      lawTitle: '刑法',
      date: '1時間前',
      comments: [],
    ),
    Discussion(
      id: 3,
      title: '著作権法の改善について',
      lawTitle: '著作権法',
      date: '1時間前',
      comments: [],
    ),
    Discussion(
      id: 4,
      title: '公証人法について',
      lawTitle: '公証人法',
      date: '1時間前',
      comments: [],
    ),
    Discussion(
      id: 5,
      title: '道路交通法の改善について',
      lawTitle: '道路交通法',
      date: '1時間前',
      comments: [],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E2129),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('タイムライン'),
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
      body: Container(
        color: const Color(0xFF1E1E1E),
        padding: const EdgeInsets.all(24.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'タイムライン',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.builder(
                      itemCount: dummyDiscussions.length,
                      itemBuilder: (context, index) {
                        final discussion = dummyDiscussions[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedDiscussion = discussion;
                              });
                            },
                            child: DiscussionCard(
                              title: discussion.title,
                              timeAgo: discussion.date,
                              tag: discussion.lawTitle,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              flex: 1,
              child: _selectedDiscussion == null
                  ? Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(color: Color(0xFF2E2E2E), width: 1),
                        ),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '議論の詳細を表示',
                            style: TextStyle(
                              color: Color(0xFFACACAC),
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            '左側のリストから気になる議論を選択してください',
                            style: TextStyle(
                              color: Color(0xFFACACAC),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    )
                  : DiscussionDetailPanel(
                      discussion: _selectedDiscussion!,
                      onBack: () {
                        setState(() {
                          _selectedDiscussion = null;
                        });
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
