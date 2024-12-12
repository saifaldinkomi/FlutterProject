// import 'package:flutter/material.dart';
// import 'package:projectfeeds/view_models/PostViewModel.dart';
// import 'package:projectfeeds/views/comments_page.dart';
// import 'package:projectfeeds/views/course_list.dart';
// import 'package:projectfeeds/views/subscribed_courses_page.dart';
// import 'package:provider/provider.dart';
// // import 'PostViewModel.dart';
// // import 'Post.dart';
// // import 'CommentsPage.dart';
// // import 'Course.dart';
// // import 'SubscribedCourses.dart';

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
//       create: (_) => PostViewModel(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Post Page"),
//         ),
//         drawer: Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                 ),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'PPU Feeds',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 margin: const EdgeInsets.all(0),
//                 padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
//                 child: ListTile(
//                   title: Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Text(
//                       "All Courses",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   onTap: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CourseList(token: token),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
//                 child: ListTile(
//                   title: Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Text(
//                       "Subscribe to a Course",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   onTap: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => SubscribedCoursesPage(token: token),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: Consumer<PostViewModel>(
//           builder: (context, viewModel, child) {
//             if (viewModel.isLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (viewModel.posts.isEmpty) {
//               return const Center(child: Text("No posts available"));
//             }

//             return ListView.builder(
//               itemCount: viewModel.posts.length,
//               itemBuilder: (context, index) {
//                 final post = viewModel.posts[index];

//                 return Card(
//                   elevation: 4,
//                   margin: const EdgeInsets.all(8),
//                   child: ListTile(
//                     title: Text(post.author),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(post.body),
//                         const SizedBox(height: 8),
//                         Text("Posted on: ${post.datePosted}"),
//                       ],
//                     ),
//                     trailing: IconButton(
//                       icon: const Icon(Icons.comment),
//                       onPressed: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CommentsPage(
//                             token: token,
//                             courseId: courseId,
//                             sectionId: sectionId,
//                             postId: post.id,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: showPostDialog(context),
//           child: const Icon(Icons.add),
//         ),
//       ),
//     );
//   }

// void showPostDialog(BuildContext context) async {
//   final postController = TextEditingController();
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text("Add New Post"),
//         content: TextField(
//           controller: postController,
//           decoration: const InputDecoration(hintText: "Enter your post content"),
//           maxLines: 4,
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text("Cancel"),
//           ),
//           TextButton(
//             onPressed: () async {
//               final postContent = postController.text.trim();
//               final viewModel = context.read<PostViewModel>();
//               try {
//                 await viewModel.addPost(token, courseId, sectionId, postContent);
//                 Navigator.of(context).pop();
//               } catch (e) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text(e.toString())),
//                 );
//               }
//             },
//             child: const Text("Post"),
//           ),
//         ],
//       );
//     },
//   );
// }


//   // void showPostDialog(BuildContext context) {
//   //   final postController = TextEditingController();
//   //   showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return AlertDialog(
//   //         title: const Text("Add New Post"),
//   //         content: TextField(
//   //           controller: postController,
//   //           decoration: const InputDecoration(hintText: "Enter your post content"),
//   //           maxLines: 4,
//   //         ),
//   //         actions: [
//   //           TextButton(
//   //             onPressed: () {
//   //               Navigator.of(context).pop();
//   //             },
//   //             child: const Text("Cancel"),
//   //           ),
//   //           TextButton(
//   //             onPressed: () {
//   //               final postContent = postController.text.trim();
//   //               final viewModel = context.read<PostViewModel>();
//   //               viewModel.addPost(token, courseId, sectionId, postContent).then((_) {
//   //                 Navigator.of(context).pop();
//   //               }).catchError((e) {
//   //                 ScaffoldMessenger.of(context).showSnackBar(
//   //                   SnackBar(content: Text(e.toString())),
//   //                 );
//   //               });
//   //             },
//   //             child: const Text("Post"),
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }
// }


import 'package:flutter/material.dart';
import 'package:projectfeeds/view_models/PostViewModel.dart';
import 'package:projectfeeds/views/comments_page.dart';
import 'package:projectfeeds/views/course_list.dart';
import 'package:projectfeeds/views/subscribed_courses_page.dart';
import 'package:provider/provider.dart';
// import 'PostViewModel.dart';
// import 'PostService.dart';
// import 'CommentsPage.dart';
// import 'Course.dart';
// import 'SubscribedCourses.dart';

class PostPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostViewModel()..getPosts(token, courseId, sectionId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Post Page"),
        ),
        drawer: _buildDrawer(context),
        body: Consumer<PostViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (viewModel.posts.isEmpty) {
              return const Center(child: Text("No posts available"));
            }
            return ListView.builder(
              itemCount: viewModel.posts.length,
              itemBuilder: (context, index) {
                final post = viewModel.posts[index];
                final postId = post['id'];

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(post['author'] ?? 'Unknown Author'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post['body'] ?? 'No content'),
                        const SizedBox(height: 8),
                        Text("Posted on: ${post['date_posted'] ?? 'Unknown date'}"),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.comment),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentsPage(
                            token: token,
                            courseId: courseId,
                            sectionId: sectionId,
                            postId: postId,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showPostDialog(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
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
          _buildDrawerItem(
            context,
            "All Courses",
            () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CourseList(token: token),
              ),
            ),
          ),
          _buildDrawerItem(
            context,
            "Subscribe to a Course",
            () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SubscribedCoursesPage(token: token),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildDrawerItem(BuildContext context, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      child: ListTile(
        title: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  void _showPostDialog(BuildContext context) {
    final postController = TextEditingController();
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
              onPressed: () async {
                final postContent = postController.text.trim();
                final viewModel = context.read<PostViewModel>();
                try {
                  await viewModel.addPost(token, courseId, sectionId, postContent);
                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              },
              child: const Text("Post"),
            ),
          ],
        );
      },
    );
  }
}
