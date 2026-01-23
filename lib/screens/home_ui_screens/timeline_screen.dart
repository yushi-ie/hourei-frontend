import 'package:flutter/material.dart';

class TimelineContent extends StatelessWidget {
  const TimelineContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(children: [
      // ゴリ押し実装なので後で型を作成する
      SizedBox(width: 508),
      Column(children: [
        SizedBox(height: 27),
        SizedBox(
          height: 600,
          child: VerticalDivider(
            width: 1,
            thickness: 1,
            color: Color(0xFF2E2E2E),
          ),
        ),
      ]),
    ]);
  }
}
