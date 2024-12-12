import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:projectfeeds/CommentService.dart';
import 'package:projectfeeds/Course.dart';
import 'package:projectfeeds/SubscribedCourses.dart'; // Import the comment service

class CommentsPage extends StatefulWidget {
  final String token;
  final int courseId;
  final int sectionId;
  final int postId;

  const CommentsPage({
    super.key,
    required this.token,
    required this.courseId,
    required this.sectionId,
    required this.postId,
  });

  @override
  State<CommentsPage> createState() => CommentsPageState();
}

class CommentsPageState extends State<CommentsPage> {
  bool isLoading = false;
  List<dynamic> comments = [];
  Map<int, bool> commentLikes = {};
  Map<int, int> commentLikeCount = {};
  final TextEditingController commentController = TextEditingController();

  // Get comments for a specific post
  Future<void> getComments() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await CommentService.getComments(
        widget.token,
        widget.courseId,
        widget.sectionId,
        widget.postId,
      );

      if (response != null) {
        setState(() {
          comments = response['comments'];
        });
        // Fetch like count and status for each comment
        for (var comment in comments) {
          final commentId = comment['id'];
          await getCommentLikesCount(commentId);
          await getCommentLikeStatus(commentId);
        }
      } else {
        print("Failed to fetch comments.");
      }
    } catch (e) {
      print('Error fetching comments: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getComments();
  }

  // Method to add a comment
  Future<void> addComment(String commentText) async {
    final String url = "http://feeds.ppu.edu/api/v1/courses/${widget.courseId}/sections/${widget.sectionId}/posts/${widget.postId}/comments";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Authorization": widget.token,
          "Content-Type": "application/json",
        },
        body: jsonEncode({"body": commentText}),
      );

      if (response.statusCode == 200) {
        setState(() {
          getComments(); // Refresh the comments list
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Comment added')),
        );
      } else {
        print('Failed to add comment. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding comment: $e');
    }
  }

  // Method to edit a comment
  Future<void> editComment(int commentId, String newText) async {
    final String url = "http://feeds.ppu.edu/api/v1/courses/${widget.courseId}/sections/${widget.sectionId}/posts/${widget.postId}/comments/$commentId";

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          "Authorization": widget.token,
          "Content-Type": "application/json",
        },
        body: jsonEncode({"body": newText}),
      );

      if (response.statusCode == 200) {
        setState(() {
          getComments(); // Refresh the comments list
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Comment updated')),
        );
      } else {
        print('Failed to edit comment. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error editing comment: $e');
    }
  }

  // Method to delete a comment
  Future<void> deleteComment(int commentId) async {
    final String url = "http://feeds.ppu.edu/api/v1/courses/${widget.courseId}/sections/${widget.sectionId}/posts/${widget.postId}/comments/$commentId";

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          "Authorization": widget.token,
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          getComments(); // Refresh the comments list
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Comment deleted')),
        );
      } else {
        print('Failed to delete comment. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting comment: $e');
    }
  }

  // Adjusted method to toggle like
  Future<void> toggleLike(int commentId) async {
    final String url =
        "http://feeds.ppu.edu/api/v1/courses/${widget.courseId}/sections/${widget.sectionId}/posts/${widget.postId}/comments/$commentId/like";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Authorization": widget.token},
      );

      if (response.statusCode == 200) {
        // Re-fetch like count and status after toggling
        await getCommentLikesCount(commentId);
        await getCommentLikeStatus(commentId);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Like status toggled successfully')),
        );
      } else {
        print('Failed to toggle like. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error toggling like: $e');
    }
  }

  // Adjusted method to fetch likes count
  Future<void> getCommentLikesCount(int commentId) async {
    final String url =
        "http://feeds.ppu.edu/api/v1/courses/${widget.courseId}/sections/${widget.sectionId}/posts/${widget.postId}/comments/$commentId/likes";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": widget.token},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          commentLikeCount[commentId] = data['likes_count'];
        });
      } else {
        print('Failed to fetch like count. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching like count: $e');
    }
  }

  // Adjusted method to fetch user like status
  Future<void> getCommentLikeStatus(int commentId) async {
    final String url =
        "http://feeds.ppu.edu/api/v1/courses/${widget.courseId}/sections/${widget.sectionId}/posts/${widget.postId}/comments/$commentId/like";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": widget.token},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          commentLikes[commentId] = data['liked'];
        });
      } else {
        print('Failed to fetch like status. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching like status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'PPU Feeds',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              child: ListTile(
                title: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "All Courses",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourseList(token: widget.token),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              child: ListTile(
                title: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Subscribe to a Course",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubscribedCoursesPage(token: widget.token),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : comments.isEmpty
              ? const Center(child: Text("No comments available"))
              : ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    final commentId = comment['id'];
                    final isLiked = commentLikes[commentId] ?? false;
                    final likeCount = commentLikeCount[commentId] ?? 0;

                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(comment['author']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(comment['body']),
                            const SizedBox(height: 8),
                            Text("Posted on: ${comment['date_posted']}"),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border),
                                  onPressed: () {
                                    toggleLike(commentId);
                                  },
                                ),
                                Text("$likeCount Likes"),
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    showEditDialog(commentId, comment['body']);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    showDeleteDialog(commentId);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddCommentDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  // Show dialog to add a comment
  void showAddCommentDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Comment'),
          content: TextField(
            controller: commentController,
            decoration: const InputDecoration(hintText: 'Enter your comment'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                addComment(commentController.text);
                commentController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // Show dialog to edit a comment
  void showEditDialog(int commentId, String currentText) {
    commentController.text = currentText;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Comment'),
          content: TextField(
            controller: commentController,
            decoration: const InputDecoration(hintText: 'Edit your comment'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                editComment(commentId, commentController.text);
                commentController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  // Show dialog to confirm delete action
  void showDeleteDialog(int commentId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Comment'),
          content: const Text('Are you sure you want to delete this comment?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteComment(commentId);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}