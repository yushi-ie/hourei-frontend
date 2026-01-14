import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'law_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final ApiService _api = ApiService();
  List<dynamic> _results = [];
  bool _loading = false;

  void _search() async {
    if (_controller.text.isEmpty) return;
    
    setState(() {
      _loading = true;
      _results = [];
    });

    try {
      final res = await _api.searchLaws(_controller.text);
      if (mounted) {
        setState(() {
          _results = res['items'] ?? [];
        });
      }
    } catch (e) {
      if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('検索エラー: $e')),
         );
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('法令検索')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'キーワード (例: 憲法)',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _search(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _search,
                  child: const Text('検索'),
                ),
              ],
            ),
          ),
          if (_loading) const LinearProgressIndicator(),
          Expanded(
            child: ListView.builder(
              itemCount: _results.length,
              itemBuilder: (context, index) {
                final item = _results[index];
                return ListTile(
                  title: Text(item['law_title'] ?? ''),
                  subtitle: Text(
                    "${item['law_num']} | ${item['category'] ?? ''}",
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // 詳細画面への遷移（未実装）
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('詳細画面は未実装です')),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
