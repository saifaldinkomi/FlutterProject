// import 'package:flutter/material.dart';
// import 'package:projectfeeds/models/Post.dart';
// import 'package:projectfeeds/models/PostService%20.dart';
// // import 'Post.dart';
// // import 'PostService.dart';

// class PostViewModel extends ChangeNotifier {
//   bool isLoading = false;
//   List<Post> posts = [];

//   // Fetch posts
//   Future<void> getPosts(String token, int courseId, int sectionId) async {
//     isLoading = true;
//     notifyListeners();

//     try {
//       final response = await PostService.getPosts(token, courseId, sectionId);
//       if (response != null) {
//         posts = (response['posts'] as List)
//             .map((post) => Post.fromJson(post))
//             .toList();
//       }
//     } catch (e) {
//       print('Error fetching posts: $e');
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   // Add post
//   Future<void> addPost(String token, int courseId, int sectionId, String postContent) async {
//     if (postContent.isEmpty) {
//       throw Exception("Post content cannot be empty");
//     }

//     isLoading = true;
//     notifyListeners();

//     try {
//       final response = await PostService.addPost(token, courseId, sectionId, postContent);
//       if (response != null) {
//         posts.insert(0, Post.fromJson(response));
//       }
//     } catch (e) {
//       print('Error adding post: $e');
//       throw Exception("Failed to add post");
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }


import 'package:flutter/material.dart';
// import 'package:projectfeeds/PostService.dart';
import 'package:projectfeeds/models/PostService%20.dart';

class PostViewModel extends ChangeNotifier {
  bool isLoading = false;
  List<dynamic> posts = [];

  Future<void> getPosts(String token, int courseId, int sectionId) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await PostService.getPosts(token, courseId, sectionId);
      if (response != null) {
        posts = response['posts'] ?? [];
      } else {
        print("Failed to fetch posts.");
      }
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addPost(String token, int courseId, int sectionId, String postContent) async {
    if (postContent.isEmpty) {
      throw 'Post content cannot be empty';
    }

    isLoading = true;
    notifyListeners();

    try {
      final response = await PostService.addPost(token, courseId, sectionId, postContent);
      if (response != null) {
        posts.insert(0, {
          'id': response['post_id'],
          'author': 'You',
          'body': postContent,
          'date_posted': DateTime.now().toString(),
        });
      } else {
        throw 'Failed to add post';
      }
    } catch (e) {
      print('Error adding post: $e');
      throw 'Error adding post';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
