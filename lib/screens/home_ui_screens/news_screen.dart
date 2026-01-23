import 'package:flutter/material.dart';

class NewsContent extends StatelessWidget {
  const NewsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'ニュース画面',
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }
}
