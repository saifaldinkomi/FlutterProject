import 'package:flutter/material.dart';
import 'package:projectfeeds/PostService%20.dart';
import 'package:projectfeeds/CommentsPage.dart';

class PostPage extends StatefulWidget {
  final String token;
  final int courseId;
  final int sectionId;

  const PostPage({
    super.key,
    required this.token,
    required this.courseId,
    required this.sectionId,
  });

  @override
  State<PostPage> createState() => PostPageState();
}

class PostPageState extends State<PostPage> {
  bool isLoading = false;
  List<dynamic> posts = [];
  final TextEditingController postController = TextEditingController();

  // Get posts
  Future<void> getPosts() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await PostService.getPosts(
        widget.token,
        widget.courseId,
        widget.sectionId,
      );

      if (response != null) {
        setState(() {
          posts = response['posts'];
        });
      } else {
        print("Failed to fetch posts.");
      }
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Add a post
  Future<void> addPost() async {
    final postContent = postController.text;
    if (postContent.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    try {
      final response = await PostService.addPost(
        widget.token,
        widget.courseId,
        widget.sectionId,
        postContent,
      );

      if (response != null) {
        setState(() {
          posts.insert(0, response['post']);
        });
        postController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Post added successfully")),
        );
      } else {
        print("Failed to add post.");
      }
    } catch (e) {
      print('Error adding post: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to add post")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Page"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : posts.isEmpty
              ? const Center(child: Text("No posts available"))
              : ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    final postId = post['id'];

                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(post['author']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post['body']),
                            const SizedBox(height: 8),
                            Text("Posted on: ${post['date_posted']}"),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.comment),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommentsPage(
                                token: widget.token,
                                courseId: widget.courseId,
                                sectionId: widget.sectionId,
                                postId: postId,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showPostDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  // Show dialog to add a post
  void _showPostDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add New Post"),
          content: TextField(
            controller: postController,
            decoration: const InputDecoration(hintText: "Enter your post content"),
            maxLines: 4,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                addPost();
                Navigator.of(context).pop();
              },
              child: const Text("Post"),
            ),
          ],
        );
      },
    );
  }
}