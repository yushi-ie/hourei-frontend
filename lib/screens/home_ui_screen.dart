import 'package:flutter/material.dart';
import 'package:hourei_flutter/screens/home_ui_screens/home_screen.dart';
import 'package:hourei_flutter/screens/home_ui_screens/timeline_screen.dart';
import 'package:hourei_flutter/screens/home_ui_screens/zyoubun_screen.dart';
import 'package:hourei_flutter/screens/home_ui_screens/news_screen.dart';
import 'package:hourei_flutter/screens/home_ui_screens/mypage_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum PageType {
  // ページをここで管理
  home,
  timeline,
  zyoubun,
  news,
  mypage,
}

class _HomeScreenState extends State<HomeScreen> {
  PageType selectedPage = PageType.home;
  bool homeIsSelected = true;
  bool timelineIsSelected = false;
  bool newIsSelected = false;
  bool myPageIsSelected = false;
  bool zyoubunIsSelected = false;

  Widget _buildRightContent() {
    switch (selectedPage) {
      case PageType.home:
        return const HomeContent();
      case PageType.timeline:
        return const TimelineContent();
      case PageType.zyoubun:
        return const ZyoubunContent();
      case PageType.news:
        return const NewsContent();
      case PageType.mypage:
        return const MyPageContent();
    }
  }

  String _getAppBarTitle() {
    switch (selectedPage) {
      case PageType.home:
        return 'ホーム';
      case PageType.timeline:
        return 'タイムライン';
      case PageType.zyoubun:
        return '条文階層';
      case PageType.news:
        return 'ニュース・時事ネタ';
      case PageType.mypage:
        return 'マイページ';
    }
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
                        // ホーム画面に遷移する処理
                        setState(() {
                          selectedPage = PageType.home;
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
                          'assets/home.png',
                        ),
                        const SizedBox(width: 18),
                        const Text('ホーム',
                            style: TextStyle(fontSize: 14, color: Colors.white))
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
                        setState(() {
                          selectedPage = PageType.timeline;
                        });
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
                          'assets/giron.png',
                        ),
                        const SizedBox(width: 18),
                        const Text('タイムライン',
                            style: TextStyle(fontSize: 14, color: Colors.white))
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
                        setState(() {
                          selectedPage = PageType.zyoubun;
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
                          'assets/kensaku.png',
                        ),
                        const SizedBox(width: 18),
                        const Text('条文階層',
                            style: TextStyle(fontSize: 14, color: Colors.white))
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
                        setState(() {
                          selectedPage = PageType.news;
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
                            style: TextStyle(fontSize: 14, color: Colors.white))
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
                        setState(() {
                          selectedPage = PageType.mypage;
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
                            style: TextStyle(fontSize: 14, color: Colors.white))
                      ])),
                ),
                const SizedBox(height: 140),
                const Divider(
                  color: Color(0xFF2E2E2E),
                  thickness: 1,
                  height: 1,
                  indent: 15,
                  endIndent: 15,
                ),
                const SizedBox(height: 20),
                const Text(
                  // 一旦これ
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
            child: Scaffold(
          backgroundColor: const Color(0xFF1E1E1E),
          appBar: AppBar(
            backgroundColor: const Color(0xFF1E2129),
            // 各画面ごとにText変更
            title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                _getAppBarTitle(),
                style: const TextStyle(
                  color: Color(0xFFACACAC),
                  fontSize: 16,
                  fontFamily: 'Inter',
                ),
              ),
            ]),
            titleTextStyle:
                const TextStyle(color: Color(0xFFACACAC), fontSize: 15),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFF2E2E2E),
              ),
            ),
          ),
          body: _buildRightContent(),
        ))
      ]),
    );
  }
}
