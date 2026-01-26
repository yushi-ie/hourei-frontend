import 'package:flutter/material.dart';

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
                        // 議論画面に遷移する処理
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
                        // タイムラインの画面に遷移する処理
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4), // ← ここを調整
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
                        // 条文階層画面に遷移する処理
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
                        // ニュース画面に遷移する処理
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
                        // マイページ画面に遷移する処理
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
                ) // 一旦これ
              ],
            ),
          ),
        ),
        Expanded(
          child: Scaffold(
            backgroundColor: const Color(0xFF1E1E1E),
            appBar: AppBar(
              backgroundColor: const Color(0xFF1E2129),
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('ホーム'),
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
                  // Left Column: Latest Discussions
                  Expanded(
                    flex: 1,
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
                      const SizedBox(height: 24),
                      Expanded(
                        child: ListView(
                          children: const [
                            DiscussionCard(
                              title: '道路交通法の改善について',
                              timeAgo: '1時間前',
                              tag: '道路交通法',
                            ),
                            SizedBox(height: 16),
                            DiscussionCard(
                              title: '道路交通法の改善について',
                              timeAgo: '1時間前',
                              tag: '道路交通法',
                            ),
                            SizedBox(height: 16),
                            DiscussionCard(
                              title: '道路交通法の改善について',
                              timeAgo: '1時間前',
                              tag: '道路交通法',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Right Column: AI Consultation
                const SizedBox(width: 24),
                Expanded(
                  flex: 1,
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
                      const SizedBox(height: 24),
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
                              // Chat Messages
                              Expanded(
                                child: ListView(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF252830),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Text(
                                          'こんにちは。法令に関する疑問や議論したい\nポイントについて教えてください。',
                                          style: TextStyle(
                                            color: Colors.white, // Colors.white
                                            height: 1.6,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF5B4DFF),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: const Text(
                                          '著作権について',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Input Field
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFAFAFA),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: '質問や提案を入力してください...',
                                          hintStyle: TextStyle(
                                            color: Color(0xFFACACAC),
                                            fontSize: 14,
                                          ),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                                        ),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF5B4DFF),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Icon(
                                        Icons.arrow_upward,
                                        color: Colors.white,
                                        size: 20,
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
                ),
              ],
            ),
          ),
        ),
      ),
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
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
