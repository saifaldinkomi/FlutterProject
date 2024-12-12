// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class PostService {
//   static const String postUrl = "http://feeds.ppu.edu/api/v1/courses";

//   // Get posts for a course and section
//   static Future<Map<String, dynamic>?> getPosts(String token, int courseId, int sectionId) async {
//     try {
//       final response = await http.get(
//         Uri.parse("$postUrl/$courseId/sections/$sectionId/posts"),
//         headers: {"Authorization": token},
//       );
//       print(response.body);
//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         print('Failed to fetch posts. Status Code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching posts: $e');
//     }
//     return null;
//   }

//   // Add a new post
//   static Future<Map<String, dynamic>?> addPost(String token, int courseId, int sectionId, String postContent) async {
//     final String url = "$postUrl/$courseId/sections/$sectionId/posts";
//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {
//           "Authorization": token,
//           "Content-Type": "application/json",
//         },
//         body: jsonEncode({"body": postContent}),
//       );

//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         print('Failed to add post. Status Code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error adding post: $e');
//     }
//     return null;
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

class PostService {
  static const String postUrl = "http://feeds.ppu.edu/api/v1/courses";

  // Get posts for a course and section
  static Future<Map<String, dynamic>?> getPosts(String token, int courseId, int sectionId) async {
    try {
      final response = await http.get(
        Uri.parse("$postUrl/$courseId/sections/$sectionId/posts"),
        headers: {"Authorization": token},
      );
      print(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Failed to fetch posts. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching posts: $e');
    }
    return null;
  }

  // Add a new post
  static Future<Map<String, dynamic>?> addPost(String token, int courseId, int sectionId, String postContent) async {
    final String url = "$postUrl/$courseId/sections/$sectionId/posts";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Authorization": token,
          "Content-Type": "application/json",
        },
        body: jsonEncode({"body": postContent}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Failed to add post. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding post: $e');
    }
    return null;
  }
}
