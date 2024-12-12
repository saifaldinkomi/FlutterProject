import 'package:flutter/material.dart';
import 'package:projectfeeds/view_models/comment_view_model.dart';
import 'package:provider/provider.dart';

class CommentsPage extends StatelessWidget {
  final String token;
  final int courseId;
  final int sectionId;
  final int postId;

  const CommentsPage({
    Key? key,
    required this.token,
    required this.courseId,
    required this.sectionId,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CommentViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Comments"),
        ),
        body: Consumer<CommentViewModel>(
          builder: (context, model, child) {
            return model.isLoading
                ? const Center(child: CircularProgressIndicator())
                : model.comments.isEmpty
                    ? const Center(child: Text("No comments available"))
                    : ListView.builder(
                        itemCount: model.comments.length,
                        itemBuilder: (context, index) {
                          final comment = model.comments[index];
                          final commentId = comment['id'];
                          final isLiked = model.commentLikes[commentId] ?? false;
                          final likeCount = model.commentLikeCount[commentId] ?? 0;

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
                                        icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
                                        onPressed: () {
                                          // Toggle like
                                        },
                                      ),
                                      Text("$likeCount Likes"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
          },
        ),
      ),
    );
  }
}
