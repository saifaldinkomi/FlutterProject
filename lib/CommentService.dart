import 'dart:convert';
import 'package:http/http.dart' as http;

class CommentService {
  static const String commentUrl = "http://feeds.ppu.edu/api/v1/courses";

  // Get comments for a post
  static Future<Map<String, dynamic>?> getComments(String token, int courseId, int sectionId, int postId) async {
    try {
      final response = await http.get(
        Uri.parse("$commentUrl/$courseId/sections/$sectionId/posts/$postId/comments"),
        headers: {"Authorization": token},
      );
print(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Failed to fetch comments. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching comments: $e');
    }
    return null;
  }
}
