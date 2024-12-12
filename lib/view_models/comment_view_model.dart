import 'package:flutter/material.dart';
import 'package:projectfeeds/models/comment_service.dart'; // Import the CommentService

class CommentViewModel extends ChangeNotifier {
  bool isLoading = false;
  List<dynamic> comments = [];
  Map<int, bool> commentLikes = {};
  Map<int, int> commentLikeCount = {};

  // Method to get comments
  Future<void> fetchComments(String token, int courseId, int sectionId, int postId) async {
    isLoading = true;
    notifyListeners();

    final response = await CommentService.getComments(token, courseId, sectionId, postId);

    if (response != null) {
      comments = response['comments'];
      // Handle the like count and status logic
      for (var comment in comments) {
        final commentId = comment['id'];
        await getCommentLikesCount(commentId);
        await getCommentLikeStatus(commentId);
      }
    }
    isLoading = false;
    notifyListeners();
  }

  // Fetch like count for a comment
  Future<void> getCommentLikesCount(int commentId) async {
    final response = await CommentService.getCommentLikesCount(commentId);
    commentLikeCount[commentId] = response['likes_count'];
    notifyListeners();
  }

  // Fetch like status for a comment
  Future<void> getCommentLikeStatus(int commentId) async {
    final response = await CommentService.getCommentLikeStatus(commentId);
    commentLikes[commentId] = response['liked'];
    notifyListeners();
  }
}
