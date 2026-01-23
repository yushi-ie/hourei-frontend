import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 25, left: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '最新の議論',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              SizedBox(height: 10),
              Text(
                '最近盛り上がった議論を表示します',
                style: TextStyle(color: Color(0xFFACACAC), fontSize: 14),
              ),
              // ここから下はバックエンドと連携次第で実装
            ],
          ),
          SizedBox(width: 250),
          SizedBox(
            height: 600,
            child: VerticalDivider(
              width: 1,
              thickness: 1,
              color: Color(0xFF2E2E2E),
            ),
          ),
          SizedBox(width: 35),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AIと相談',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                'AIに気軽に相談してみましょう',
                style: TextStyle(color: Color(0xFFACACAC), fontSize: 12),
              ),
              // ここから下はバックエンドと連携次第で実装
            ],
          ),
        ],
      ),
    );
  }
}
