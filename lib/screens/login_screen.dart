import 'package:flutter/material.dart';
import 'timeline_screen.dart';
import 'search_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    TimelineScreen(),
    SearchScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/hourei.png', width: 100, height: 100),
        const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Loophole',
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 40,
                  fontWeight: FontWeight.w300)),
          SizedBox(width: 8),
          Text('Rager',
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 40,
                  fontWeight: FontWeight.w700)),
        ]),
        const SizedBox(height: 40),
        const SizedBox(
          width: 300,
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person_outline,
                size: 45,
              ),
              hintText: 'User ID',
              hintStyle: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w300),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const SizedBox(
            width: 300,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline, size: 45),
                hintText: 'Password',
                hintStyle: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w300),
                border: OutlineInputBorder(),
              ),
            )),
        const SizedBox(height: 20),
        SizedBox(
          width: 300,
          height: 50,
          child: ElevatedButton(
              onPressed: () {
                // ログイン処理をここに追加
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4), // ← ここを調整
                  ),
                  backgroundColor: Colors.indigo),
              child: const Text('ログイン',
                  style: TextStyle(
                      fontSize: 15, fontFamily: 'Inter', color: Colors.white))),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: 300,
          height: 50,
          child: ElevatedButton(
              onPressed: () {
                // アカウント作成の処理をここに追加
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4), // ← ここを調整
                  ),
                  backgroundColor: Colors.black),
              child: const Text('アカウント作成',
                  style: TextStyle(
                      fontSize: 15, fontFamily: 'Inter', color: Colors.white))),
        ),
      ])),
    );
  }
}
