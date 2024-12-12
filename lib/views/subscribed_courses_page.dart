// import 'package:flutter/material.dart';
// import 'package:projectfeeds/models/course_service.dart';
// import 'package:projectfeeds/views/course_list.dart';
// import 'package:provider/provider.dart';
// import '../view_models/subscription_view_model.dart';
// import 'course_item_widget.dart';

// class SubscribedCoursesPage extends StatelessWidget {
//   final String token;

//   const SubscribedCoursesPage({super.key, required this.token});

//   @override
//   Widget build(BuildContext context) {
//     // Use ChangeNotifierProvider to fetch data
//     return ChangeNotifierProvider(
//       create: (_) => SubscriptionViewModel(CourseService())..fetchSubscriptions(token),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Subscribed Courses"),
//         ),
//         drawer: _buildDrawer(context),
//         body: Consumer<SubscriptionViewModel>(builder: (context, viewModel, child) {
//           if (viewModel.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (viewModel.courseSubscriptions.isEmpty) {
//             return const Center(child: Text("No subscribed courses"));
//           } else {
//             return ListView.builder(
//               itemCount: viewModel.courseSubscriptions.length,
//               itemBuilder: (context, index) {
//                 final subscription = viewModel.courseSubscriptions[index];
//                 return CourseItemWidget(subscription: subscription);
//               },
//             );
//           }
//         }),
//       ),
//     );
//   }
// }

// // class SubscribedCoursesPage extends StatelessWidget {
// //   final String token;

// //   const SubscribedCoursesPage({super.key, required this.token});

// //   @override
// //   Widget build(BuildContext context) {
// //     return ChangeNotifierProvider(
// //       create: (_) => SubscriptionViewModel(CourseService()),
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: const Text("Subscribed Courses"),
// //         ),
// //          drawer: _buildDrawer(context),
// //         body: Consumer<SubscriptionViewModel>(
// //           builder: (context, viewModel, child) {
// //             if (viewModel.isLoading) {
// //               return const Center(child: CircularProgressIndicator());
// //             } else if (viewModel.courseSubscriptions.isEmpty) {
// //               return const Center(child: Text("No subscribed courses"));
// //             } else {
// //               return ListView.builder(
// //                 itemCount: viewModel.courseSubscriptions.length,
// //                 itemBuilder: (context, index) {
// //                   final subscription = viewModel.courseSubscriptions[index];
// //                   return CourseItemWidget(subscription: subscription);
// //                 },
// //               );
// //             }
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }
// // Drawer _buildDrawer(BuildContext context) {
// //     return Drawer(
// //       child: ListView(
// //         padding: EdgeInsets.zero,
// //         children: [
// //           DrawerHeader(
// //             decoration: BoxDecoration(
// //               color: Colors.blue,
// //             ),
// //             child: Align(
// //               alignment: Alignment.centerLeft,
// //               child: Text(
// //                 'PPU Feeds',
// //                 style: TextStyle(
// //                   color: Colors.white,
// //                   fontSize: 20,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //             ),
// //             margin: const EdgeInsets.all(0),
// //             padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
// //           ),
// //           _buildDrawerItem(
// //             context,
// //             "All Courses",
// //             () =>{} 
// //             // Navigator.pushReplacement(
// //             //   context,
// //             //   MaterialPageRoute(
// //             //     builder: (context) => CourseList(token: widget.token),
// //             //   ),
// //             // ),
// //           ),
// //           _buildDrawerItem(
// //             context,
// //             "Subscribed Courses",
// //             () => {}
// //             // Navigator.pushReplacement(
// //             //   context,
// //             //   MaterialPageRoute(
// //             //     builder: (context) => SubscribedCoursesPage(token: token),
// //             //   ),
// //             // ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// Drawer _buildDrawer(BuildContext context) {
//   return Drawer(
//     child: ListView(
//       padding: EdgeInsets.zero,
//       children: [
//         DrawerHeader(
//           decoration: BoxDecoration(
//             color: Colors.blue,
//           ),
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'PPU Feeds',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           margin: const EdgeInsets.all(0),
//           padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//         ),
//         _buildDrawerItem(
//           context,
//           "All Courses",
//           () {
//             // Add your navigation logic here, e.g.:
//             // Navigator.pushReplacement(
//             //   context,
//             //   MaterialPageRoute(
//             //     builder: (context) => CourseList(token: token), // Pass token
//             //   ),
//             // );
//           },
//         ),
//         _buildDrawerItem(
//           context,
//           "Subscribed Courses",
//           () {
//             // Add navigation to the subscribed courses page
//             // Navigator.pushReplacement(
//             //   context,
//             //   MaterialPageRoute(
//             //     builder: (context) => SubscribedCoursesPage(token: token),
//             //   ),
//             // );
//           },
//         ),
//       ],
//     ),
//   );
// }


//   // Helper function to create drawer items
//   Padding _buildDrawerItem(BuildContext context, String title, VoidCallback onTap) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
//       child: ListTile(
//         title: Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: Colors.grey[200],
//             border: Border.all(color: Colors.grey),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Text(
//             title,
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontSize: 16),
//           ),
//         ),
//         onTap: onTap,
//       ),
//     );
//   }

import 'package:flutter/material.dart';
import 'package:projectfeeds/views/course_list.dart';
import 'package:provider/provider.dart';
import '../models/course_service.dart';
import '../view_models/subscription_view_model.dart';
import 'course_item_widget.dart';

class SubscribedCoursesPage extends StatefulWidget {
  final String token;

  const SubscribedCoursesPage({super.key, required this.token});

  @override
  _SubscribedCoursesPageState createState() => _SubscribedCoursesPageState();
}

class _SubscribedCoursesPageState extends State<SubscribedCoursesPage> {
  @override
  void initState() {
    super.initState();
    // Fetch subscriptions when the page is initialized
    Provider.of<SubscriptionViewModel>(context, listen: false)
        .fetchSubscriptions(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SubscriptionViewModel(CourseService()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Subscribed Courses"),
        ),
        drawer: _buildDrawer(context),
        body: Consumer<SubscriptionViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (viewModel.courseSubscriptions.isEmpty) {
              return const Center(child: Text("No subscribed courses"));
            } else {
              return ListView.builder(
                itemCount: viewModel.courseSubscriptions.length,
                itemBuilder: (context, index) {
                  final subscription = viewModel.courseSubscriptions[index];
                  return CourseItemWidget(subscription: subscription);
                },
              );
            }
          },
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
            () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseList(token: widget.token),
                ),
              );
            },
          ),
          _buildDrawerItem(
            context,
            "Subscribed Courses",
            () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SubscribedCoursesPage(token: widget.token),
                ),
              );
            },
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
}
