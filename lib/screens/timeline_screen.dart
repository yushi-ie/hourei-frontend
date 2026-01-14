import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/discussion.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  final ApiService _api = ApiService();
  late Future<List<Discussion>> _timelineFuture;

  @override
  void initState() {
    super.initState();
    _timelineFuture = _api.getTimeline();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('議論タイムライン'),
      ),
      body: FutureBuilder<List<Discussion>>(
        future: _timelineFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('エラーが発生しました: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('議論がありません'));
          }

          final discussions = snapshot.data!;
          return ListView.builder(
            itemCount: discussions.length,
            itemBuilder: (context, index) {
              final item = discussions[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: const Icon(Icons.gavel, color: Colors.blueGrey),
                  title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${item.lawTitle}\n${item.date}'),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // リフレッシュ処理
          setState(() {
            _timelineFuture = _api.getTimeline();
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
