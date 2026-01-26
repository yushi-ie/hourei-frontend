import 'package:flutter/material.dart';
import 'timeline_screen.dart';

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

  Widget _getSelectedScreen() {
    if (timelineIsSelected) {
      return const TimelineScreen();
    }
    // デフォルトはホーム画面(空のプレースホルダー)
    return Scaffold(
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
      body: const Center(
        child: Text(
          'ホーム画面(準備中)',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
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
