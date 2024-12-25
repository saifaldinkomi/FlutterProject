// import 'package:flutter/material.dart';
// import 'package:projectfeeds/models/post_model.dart';
// import 'package:projectfeeds/view_models/Post_view_model.dart';
// import 'package:projectfeeds/views/comments_page.dart';
// import 'package:projectfeeds/views/course_list_page.dart';
// import 'package:projectfeeds/views/drawer.dart';
// import 'package:projectfeeds/views/subscribed_courses_page.dart';
// import 'package:provider/provider.dart';

// class PostPage extends StatelessWidget {
//   final String token;
//   final int courseId;
//   final int sectionId;

//   const PostPage({
//     super.key,
//     required this.token,
//     required this.courseId,
//     required this.sectionId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => PostViewModel(
//         token: token,
//         courseId: courseId,
//         sectionId: sectionId,
//       )..fetchPosts(),
//       child: Consumer<PostViewModel>(
//         builder: (context, viewModel, child) {
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text("Post Page"),
//             ),
//             drawer: DrowerPage(token: token),
//             body: viewModel.isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : viewModel.posts.isEmpty
//                     ? const Center(child: Text("No posts available"))
//                     : ListView.builder(
//                         itemCount: viewModel.posts.length,
//                         itemBuilder: (context, index) {
//                           final post = viewModel.posts[index];
//                           return Card(
//                             elevation: 4,
//                             margin: const EdgeInsets.all(8),
//                             child: ListTile(
//                               title: Text(post.author),
//                               subtitle: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(post.body),
//                                   const SizedBox(height: 8),
//                                   Text("Posted on: ${post.datePosted}"),
//                                 ],
//                               ),
//                               trailing: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   IconButton(
//                                     icon: const Icon(Icons.edit),
//                                     onPressed: () => _showEditDialog(
//                                         context, viewModel, post),
//                                   ),
//                                   IconButton(
//                                     icon: const Icon(Icons.comment),
//                                     onPressed: () => Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => CommentsPage(
//                                           token: token,
//                                           courseId: courseId,
//                                           sectionId: sectionId,
//                                           postId: post.id,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//             floatingActionButton: FloatingActionButton(
//               onPressed: () => _showPostDialog(context, viewModel),
//               child: const Icon(Icons.add),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   void _showPostDialog(BuildContext context, PostViewModel viewModel) {
//     final TextEditingController postController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Add New Post"),
//           content: TextField(
//             controller: postController,
//             decoration:
//                 const InputDecoration(hintText: "Enter your post content"),
//             maxLines: 4,
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () {
//                 viewModel.addNewPost(postController.text);
//                 Navigator.of(context).pop();
//               },
//               child: const Text("Post"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showEditDialog(
//       BuildContext context, PostViewModel viewModel, Post post) {
//     final TextEditingController postController =
//         TextEditingController(text: post.body);

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Edit Post"),
//           content: TextField(
//             controller: postController,
//             decoration:
//                 const InputDecoration(hintText: "Edit your post content"),
//             maxLines: 4,
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () {
//                 viewModel.editPost(post.id, postController.text);
//                 Navigator.of(context).pop();
//               },
//               child: const Text("Update"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:projectfeeds/models/post_model.dart';
import 'package:projectfeeds/view_models/Post_view_model.dart';
import 'package:projectfeeds/views/comments_page.dart';
import 'package:projectfeeds/views/course_list_page.dart';
import 'package:projectfeeds/views/drawer.dart';
import 'package:projectfeeds/views/subscribed_courses_page.dart';

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
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late PostViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = PostViewModel(
      token: widget.token,
      courseId: widget.courseId,
      sectionId: widget.sectionId,
    );
    _viewModel.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Page"),
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.blue,
      //         ),
      //         child: Align(
      //           alignment: Alignment.centerLeft,
      //           child: Text(
      //             'PPU Feeds',
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontSize: 20,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //         ),
      //         margin: const EdgeInsets.all(0),
      //         padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      //         child: ListTile(
      //           title: Container(
      //             padding: const EdgeInsets.all(10),
      //             decoration: BoxDecoration(
      //               color: Colors.grey[200],
      //               border: Border.all(color: Colors.grey),
      //               borderRadius: BorderRadius.circular(8),
      //             ),
      //             child: const Text(
      //               "All Courses",
      //               textAlign: TextAlign.center,
      //               style: TextStyle(fontSize: 16),
      //             ),
      //           ),
      //           onTap: () {
      //             Navigator.pushReplacement(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => CourseList(token: widget.token),
      //               ),
      //             );
      //           },
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      //         child: ListTile(
      //           title: Container(
      //             padding: const EdgeInsets.all(10),
      //             decoration: BoxDecoration(
      //               color: Colors.grey[200],
      //               border: Border.all(color: Colors.grey),
      //               borderRadius: BorderRadius.circular(8),
      //             ),
      //             child: const Text(
      //               "Subscribe to a Course",
      //               textAlign: TextAlign.center,
      //               style: TextStyle(fontSize: 16),
      //             ),
      //           ),
      //           onTap: () {
      //             Navigator.pushReplacement(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => SubscribedCoursesPage(token: widget.token),
      //               ),
      //             );
      //           },
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
     drawer: DrowerPage(token: widget.token),
     body: _viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _viewModel.posts.isEmpty
              ? const Center(child: Text("No posts available"))
              : ListView.builder(
                  itemCount: _viewModel.posts.length,
                  itemBuilder: (context, index) {
                    final post = _viewModel.posts[index];
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(post.author),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post.body),
                            const SizedBox(height: 8),
                            Text("Posted on: ${post.datePosted}"),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _showEditDialog(context, post),
                            ),
                            IconButton(
                              icon: const Icon(Icons.comment),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CommentsPage(
                                    token: widget.token,
                                    courseId: widget.courseId,
                                    sectionId: widget.sectionId,
                                    postId: post.id,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showPostDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showPostDialog(BuildContext context) {
    final TextEditingController postController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Post"),
          content: TextField(
            controller: postController,
            decoration: const InputDecoration(hintText: "Enter your post content"),
            maxLines: 4,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _viewModel.addNewPost(postController.text);
                Navigator.of(context).pop();
              },
              child: const Text("Post"),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, Post post) {
    final TextEditingController postController = TextEditingController(text: post.body);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Post"),
          content: TextField(
            controller: postController,
            decoration: const InputDecoration(hintText: "Edit your post content"),
            maxLines: 4,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _viewModel.editPost(post.id, postController.text);
                Navigator.of(context).pop();
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
