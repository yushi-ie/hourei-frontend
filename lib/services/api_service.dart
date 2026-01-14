import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../models/discussion.dart';

class ApiService {
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
}
