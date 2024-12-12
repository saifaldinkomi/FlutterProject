// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class CommentService {
//   static const String commentUrl = "http://feeds.ppu.edu/api/v1/courses";

//   // Get comments for a post
//   static Future<Map<String, dynamic>?> getComments(String token, int courseId, int sectionId, int postId) async {
//     try {
//       final response = await http.get(
//         Uri.parse("$commentUrl/$courseId/sections/$sectionId/posts/$postId/comments"),
//         headers: {"Authorization": token},
//       );

//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         print('Failed to fetch comments. Status Code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching comments: $e');
//     }
//     return null;
//   }

//   // Add comment
//   static Future<void> addComment(String token, int courseId, int sectionId, int postId, String commentText) async {
//     final String url = "http://feeds.ppu.edu/api/v1/courses/$courseId/sections/$sectionId/posts/$postId/comments";

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {
//           "Authorization": token,
//           "Content-Type": "application/json",
//         },
//         body: jsonEncode({"body": commentText}),
//       );

//       if (response.statusCode == 200) {
//         print('Comment added');
//       } else {
//         print('Failed to add comment. Status Code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error adding comment: $e');
//     }
//   }
  
//   // Other methods for editing and deleting comments will follow a similar pattern.
// }
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

  // Add comment
  static Future<void> addComment(String token, int courseId, int sectionId, int postId, String commentText) async {
    final String url = "http://feeds.ppu.edu/api/v1/courses/$courseId/sections/$sectionId/posts/$postId/comments";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Authorization": token,
          "Content-Type": "application/json",
        },
        body: jsonEncode({"body": commentText}),
      );

      if (response.statusCode == 200) {
        print('Comment added');
      } else {
        print('Failed to add comment. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding comment: $e');
    }
  }

  // Get like count for a comment
  static Future<Map<String, dynamic>> getCommentLikesCount(int commentId) async {
    final String url = "http://feeds.ppu.edu/api/v1/comments/$commentId/likes_count";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Failed to fetch like count. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching like count: $e');
    }
    return {};
  }

  // Get like status (liked or not) for a comment
  static Future<Map<String, dynamic>> getCommentLikeStatus(int commentId) async {
    final String url = "http://feeds.ppu.edu/api/v1/comments/$commentId/like_status";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Failed to fetch like status. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching like status: $e');
    }
    return {};
  }

  // Add like to a comment
  static Future<void> addLike(String token, int commentId) async {
    final String url = "http://feeds.ppu.edu/api/v1/comments/$commentId/like";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Authorization": token,
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        print('Like added');
      } else {
        print('Failed to add like. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding like: $e');
    }
  }
}
