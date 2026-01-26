import 'package:flutter/material.dart';
import '../widgets/discussion_card.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  // Dummy data for now, replacing FutureBuilder logic for UI alignment
  final List<Map<String, String>> dummyDiscussions = [
    {
      'title': '道路交通法の改善について',
      'timeAgo': '1時間前',
      'tag': '道路交通法',
    },
    {
      'title': '刑法について',
      'timeAgo': '1時間前',
      'tag': '刑法',
    },
    {
      'title': '著作権法の改善について',
      'timeAgo': '1時間前',
      'tag': '著作権法',
    },
    {
      'title': '公証人法について',
      'timeAgo': '1時間前',
      'tag': '公証人法',
    },
    {
      'title': '道路交通法の改善について',
      'timeAgo': '1時間前',
      'tag': '道路交通法',
    },
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
                        final item = dummyDiscussions[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: DiscussionCard(
                            title: item['title']!,
                            timeAgo: item['timeAgo']!,
                            tag: item['tag']!,
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
              flex: 1, // Split view ratio 1:1 for now, adjust if needed (image looks like maybe 4:6 or 1:1)
              child: Container(
                decoration: const BoxDecoration(
                   border: Border(
                     left: BorderSide(color: Color(0xFF2E2E2E), width: 1),
                   )
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
