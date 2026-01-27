import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../models/discussion.dart';
import '../models/law.dart';
import '../models/news_item.dart';
import '../models/law_tree_item.dart';
import '../models/chat_message.dart';

class ApiService {
  Future<LawDetail> getLawDetail(String lawId) async {
    final url = Uri.parse('${Config.baseUrl}/api/laws/$lawId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final body = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> data = json.decode(body);
        return LawDetail.fromJson(data);
      } else {
        throw Exception('Failed to load law detail: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching law detail: $e");
      rethrow;
    }
  }
  Future<List<Discussion>> getTimeline() async {
    final url = Uri.parse('${Config.baseUrl}/api/timeline');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // UTF-8 decoding is required for Japanese characters
        final body = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> data = json.decode(body);
        final List<dynamic> list = data['discussions'];
        
        return list.map((e) => Discussion.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load timeline: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching timeline: $e");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> searchLaws(String keyword) async {
    final url = Uri.parse('${Config.baseUrl}/laws/search?keyword=$keyword');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final body = utf8.decode(response.bodyBytes);
        return json.decode(body);
      } else {
         throw Exception('Search failed');
      }
    } catch (e) {
      print("Error searching: $e");
      return {};
    }
  }

  Future<List<NewsItem>> getNews() async {
    final url = Uri.parse('${Config.baseUrl}/api/news');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final body = utf8.decode(response.bodyBytes);
        final List<dynamic> data = json.decode(body);
        return data.map((e) => NewsItem.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching news: $e");
      rethrow;
    }
  }

  Future<List<LawTreeItem>> getLawTree({String? category}) async {
    final url = category != null
        ? Uri.parse('${Config.baseUrl}/laws/tree?category=$category')
        : Uri.parse('${Config.baseUrl}/laws/tree');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final body = utf8.decode(response.bodyBytes);
        final List<dynamic> data = json.decode(body);
        return data.map((e) => LawTreeItem.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load law tree: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching law tree: $e");
      rethrow;
    }
  }

  Future<Discussion> createDiscussion({
    required String title,
    required String lawId,
    required String lawTitle,
    required int userId,
  }) async {
    final url = Uri.parse('${Config.baseUrl}/api/discussions');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': title,
          'law_id': lawId,
          'law_title': lawTitle,
          'user_id': userId,
        }),
      );
      if (response.statusCode == 200) {
        final body = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> data = json.decode(body);
        return Discussion.fromJson(data);
      } else {
        throw Exception('Failed to create discussion: ${response.statusCode}');
      }
    } catch (e) {
      print("Error creating discussion: $e");
      rethrow;
    }
  }

  Future<ChatMessage> sendChatMessage(List<ChatMessage> messages) async {
    final url = Uri.parse('${Config.baseUrl}/api/ai/chat');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'messages': messages.map((m) => m.toJson()).toList(),
        }),
      );
      if (response.statusCode == 200) {
        final body = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> data = json.decode(body);
        return ChatMessage.fromJson(data);
      } else {
        throw Exception('Failed to send chat message: ${response.statusCode}');
      }
    } catch (e) {
      print("Error sending chat message: $e");
      rethrow;
    }
  }

  Future<List<String>> analyzeNews(String title, String summary) async {
    final url = Uri.parse('${Config.baseUrl}/api/news/analyze');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': title,
          'summary': summary,
        }),
      );
      if (response.statusCode == 200) {
        final body = utf8.decode(response.bodyBytes);
        final List<dynamic> data = json.decode(body);
        return data.map((e) => e.toString()).toList();
      } else {
        throw Exception('Failed to analyze news: ${response.statusCode}');
      }
    } catch (e) {
      print("Error analyzing news: $e");
      return [];
    }
  }
}
