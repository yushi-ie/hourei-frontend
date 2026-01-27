import 'package:flutter/material.dart';
import 'timeline_screen.dart';
import 'law_detail_screen.dart';
import 'news_screen.dart';
import '../services/api_service.dart';
import '../models/discussion.dart';
import '../models/chat_message.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool homeIsSelected = true;
  bool timelineIsSelected = false;
  bool newIsSelected = false;
  bool myPageIsSelected = false;
  bool zyoubunIsSelected = false;

  // State for navigating to a specific law from news
  String? _targetLawId;
  String? _targetLawTitle;

  Widget _getSelectedScreen() {
    if (timelineIsSelected) {
      return const TimelineScreen();
    }
    if (newIsSelected) {
      return NewsScreen(
        onNavigateToLaw: (lawId, lawTitle) {
          setState(() {
            _targetLawId = lawId;
            _targetLawTitle = lawTitle;
            newIsSelected = false;
            zyoubunIsSelected = true;
          });
        },
      );
    }
    if (zyoubunIsSelected) {
      // Use a Key to ensure LawDetailScreen is recreated when navigating to a specific law
      return LawDetailScreen(
        key: _targetLawId != null ? ValueKey(_targetLawId) : null,
        initialLawId: _targetLawId,
        initialLawTitle: _targetLawTitle,
      );
    }
    // ホーム画面
    return const HomeContentScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: Row(children: [
        SizedBox(
          width: 251,
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF1E2129),
              border: Border(
                right: BorderSide(
                  width: 1,
                  color: Color(0xFF2E2E2E),
                ),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 4,
                ),
                Container(
                    height: 75,
                    alignment: Alignment.center,
                    child: Row(children: [
                      const SizedBox(width: 20),
                      Image.asset(
                        'assets/hourei.png',
                        width: 35,
                        height: 35,
                        color: const Color(0xFFFAFAFA),
                      ),
                      const Text(
                        'Loophone',
                        style: TextStyle(
                          color: Color(0xFFFAFAFA),
                          fontSize: 16,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      const Text(
                        'Radar',
                        style: TextStyle(
                          color: Color(0xFFFAFAFA),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ])),
                const Divider(
                  color: Color(0xFF2E2E2E),
                  thickness: 1,
                  height: 1,
                  indent: 15,
                  endIndent: 15,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 232,
                  height: 44,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          homeIsSelected = true;
                          timelineIsSelected = false;
                          newIsSelected = false;
                          myPageIsSelected = false;
                          zyoubunIsSelected = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          backgroundColor: homeIsSelected
                              ? const Color(0xFF3E3E3E)
                              : const Color(0xFF1E2129)),
                      child: Row(children: [
                        Image.asset(
                          'assets/giron.png',
                        ),
                        const SizedBox(width: 18),
                        const Text('ホーム',
                            style: TextStyle(fontSize: 15, color: Colors.white))
                      ])),
                ),
                const SizedBox(height: 35),
                SizedBox(
                  width: 232,
                  height: 44,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          timelineIsSelected = true;
                          homeIsSelected = false;
                          newIsSelected = false;
                          myPageIsSelected = false;
                          zyoubunIsSelected = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          backgroundColor: timelineIsSelected
                              ? const Color(0xFF3E3E3E)
                              : const Color(0xFF1E2129)),
                      child: Row(children: [
                        Image.asset(
                          'assets/kensaku.png',
                        ),
                        const SizedBox(width: 18),
                        const Text('タイムライン',
                            style: TextStyle(fontSize: 15, color: Colors.white))
                      ])),
                ),
                const SizedBox(height: 35),
                SizedBox(
                  width: 232,
                  height: 44,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          zyoubunIsSelected = true;
                          newIsSelected = false;
                          timelineIsSelected = false;
                          homeIsSelected = false;
                          myPageIsSelected = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          backgroundColor: zyoubunIsSelected
                              ? const Color(0xFF3E3E3E)
                              : const Color(0xFF1E2129)),
                      child: Row(children: [
                        Image.asset(
                          'assets/news.png',
                        ),
                        const SizedBox(width: 18),
                        const Text('条文階層',
                            style: TextStyle(fontSize: 15, color: Colors.white))
                      ])),
                ),
                const SizedBox(height: 35),
                SizedBox(
                  width: 232,
                  height: 44,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          newIsSelected = true;
                          timelineIsSelected = false;
                          homeIsSelected = false;
                          myPageIsSelected = false;
                          zyoubunIsSelected = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          backgroundColor: newIsSelected
                              ? const Color(0xFF3E3E3E)
                              : const Color(0xFF1E2129)),
                      child: Row(children: [
                        Image.asset(
                          'assets/news.png',
                        ),
                        const SizedBox(width: 18),
                        const Text('ニュース・時事ネタ',
                            style: TextStyle(fontSize: 15, color: Colors.white))
                      ])),
                ),
                const SizedBox(height: 35),
                SizedBox(
                  width: 232,
                  height: 44,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          myPageIsSelected = true;
                          newIsSelected = false;
                          timelineIsSelected = false;
                          homeIsSelected = false;
                          zyoubunIsSelected = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          backgroundColor: myPageIsSelected
                              ? const Color(0xFF3E3E3E)
                              : const Color(0xFF1E2129)),
                      child: Row(children: [
                        Image.asset(
                          'assets/mypage.png',
                        ),
                        const SizedBox(width: 18),
                        const Text('マイページ',
                            style: TextStyle(fontSize: 15, color: Colors.white))
                      ])),
                ),
                const SizedBox(height: 220),
                const Divider(
                  color: Color(0xFF2E2E2E),
                  thickness: 1,
                  height: 1,
                  indent: 15,
                  endIndent: 15,
                ),
                const SizedBox(height: 20),
                const Text(
                  'UserIDXXXXXXX',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: _getSelectedScreen(),
        )
      ]),
    );
  }
}

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
                ),
              ),
              const SizedBox(width: 16),
              Text(
                timeAgo,
                style: const TextStyle(
                  color: Color(0xFFACACAC),
                  fontSize: 14,
                ),
              ),
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

// ホーム画面のメインコンテンツ
class HomeContentScreen extends StatefulWidget {
  const HomeContentScreen({super.key});

  @override
  State<HomeContentScreen> createState() => _HomeContentScreenState();
}

class _HomeContentScreenState extends State<HomeContentScreen> {
  final ApiService _apiService = ApiService();
  List<Discussion> _discussions = [];
  bool _isLoadingDiscussions = true;
  
  final List<ChatMessage> _chatMessages = [];
  final TextEditingController _chatController = TextEditingController();
  bool _isSendingMessage = false;

  @override
  void initState() {
    super.initState();
    _loadDiscussions();
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  Future<void> _loadDiscussions() async {
    try {
      final discussions = await _apiService.getTimeline();
      setState(() {
        _discussions = discussions;
        _isLoadingDiscussions = false;
      });
    } catch (e) {
      print('Error loading discussions: $e');
      setState(() {
        _isLoadingDiscussions = false;
      });
    }
  }

  Future<void> _sendMessage() async {
    if (_chatController.text.trim().isEmpty) return;

    final userMessage = ChatMessage(
      role: 'user',
      content: _chatController.text.trim(),
    );

    setState(() {
      _chatMessages.add(userMessage);
      _isSendingMessage = true;
    });

    _chatController.clear();

    try {
      final response = await _apiService.sendChatMessage(_chatMessages);
      setState(() {
        _chatMessages.add(response);
        _isSendingMessage = false;
      });
    } catch (e) {
      print('Error sending message: $e');
      setState(() {
        _isSendingMessage = false;
      });
    }
  }

  String _formatTimeAgo(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 0) {
        return '${difference.inDays}日前';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}時間前';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}分前';
      } else {
        return 'たった今';
      }
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E2129),
        title: const Text('ホーム'),
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
      body: Row(
        children: [
          // 左側: 最新の議論
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '最新の議論',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '最近盛り上がった議論を表示しています',
                    style: TextStyle(
                      color: Color(0xFFACACAC),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: _isLoadingDiscussions
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF5E5CE6),
                            ),
                          )
                        : _discussions.isEmpty
                            ? const Center(
                                child: Text(
                                  '議論がまだありません',
                                  style: TextStyle(
                                    color: Color(0xFFACACAC),
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            : ListView.separated(
                                itemCount: _discussions.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 16),
                                itemBuilder: (context, index) {
                                  final discussion = _discussions[index];
                                  return DiscussionCard(
                                    title: discussion.title,
                                    timeAgo: _formatTimeAgo(discussion.date),
                                    tag: discussion.lawTitle,
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
          ),
          // 右側: AIと相談
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'AIと相談',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'AIに気軽に相談してみましょう',
                    style: TextStyle(
                      color: Color(0xFFACACAC),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E2129),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFF2E2E2E)),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: _chatMessages.isEmpty
                                ? const Center(
                                    child: Text(
                                      'こんにちは、法令に関する質問があれば\nポイントについて教えてください。',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFFACACAC),
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: _chatMessages.length,
                                    itemBuilder: (context, index) {
                                      final message = _chatMessages[index];
                                      final isUser = message.role == 'user';
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 16),
                                        child: Row(
                                          mainAxisAlignment: isUser
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.start,
                                          children: [
                                            if (!isUser)
                                              Container(
                                                width: 32,
                                                height: 32,
                                                margin: const EdgeInsets.only(right: 12),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFF5E5CE6),
                                                  borderRadius: BorderRadius.circular(16),
                                                ),
                                                child: const Icon(
                                                  Icons.smart_toy,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            Flexible(
                                              child: Container(
                                                padding: const EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  color: isUser
                                                      ? const Color(0xFF5E5CE6)
                                                      : const Color(0xFF252830),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  message.content,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          if (_isSendingMessage)
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                color: Color(0xFF5E5CE6),
                              ),
                            ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _chatController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: '質問や相談を入力してください...',
                                    hintStyle: const TextStyle(
                                      color: Color(0xFFACACAC),
                                    ),
                                    filled: true,
                                    fillColor: const Color(0xFF252830),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                  ),
                                  onSubmitted: (_) => _sendMessage(),
                                ),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton(
                                onPressed: _isSendingMessage ? null : _sendMessage,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF5E5CE6),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  '送信について',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
