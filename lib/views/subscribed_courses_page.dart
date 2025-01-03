// import 'package:flutter/material.dart';
// import 'package:projectfeeds/views/drawer.dart';
// import 'package:provider/provider.dart';
// import 'package:projectfeeds/view_models/subscribed_courses_viewmodel.dart';
// import 'package:projectfeeds/views/course_detail_page.dart';
// import 'package:projectfeeds/models/course_subscription_model.dart';

// class SubscribedCoursesPage extends StatelessWidget {
//   final String token;

//   const SubscribedCoursesPage({super.key, required this.token});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) =>
//           SubscribedCoursesViewModel(token: token)..fetchSubscriptions(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Subscribed Courses"),
//         ),
//         // drawer: Drawer(
//         //   child: ListView(
//         //     padding: EdgeInsets.zero,
//         //     children: [
//         //       DrawerHeader(
//         //         decoration: BoxDecoration(
//         //           color: Colors.blue,
//         //         ),
//         //         child: Align(
//         //           alignment: Alignment.centerLeft,
//         //           child: Text(
//         //             'PPU Feeds',
//         //             style: TextStyle(
//         //               color: Colors.white,
//         //               fontSize: 20,
//         //               fontWeight: FontWeight.bold,
//         //             ),
//         //           ),
//         //         ),
//         //         margin: const EdgeInsets.all(0),
//         //         padding:
//         //             const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//         //       ),
//         //       Padding(
//         //         padding:
//         //             const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
//         //         child: ListTile(
//         //           title: Container(
//         //             padding: const EdgeInsets.all(10),
//         //             decoration: BoxDecoration(
//         //               color: Colors.grey[200],
//         //               border: Border.all(color: Colors.grey),
//         //               borderRadius: BorderRadius.circular(8),
//         //             ),
//         //             child: const Text(
//         //               "All Courses",
//         //               textAlign: TextAlign.center,
//         //               style: TextStyle(fontSize: 16),
//         //             ),
//         //           ),
//         //           onTap: () {
//         //             Navigator.pushReplacement(
//         //               context,
//         //               MaterialPageRoute(
//         //                 builder: (context) => CourseList(token: token)
//         //               ),
//         //             );
//         //           },
//         //         ),
//         //       ),
//         //       Padding(
//         //         padding:
//         //             const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
//         //         child: ListTile(
//         //           title: Container(
//         //             padding: const EdgeInsets.all(10),
//         //             decoration: BoxDecoration(
//         //               color: Colors.grey[200],
//         //               border: Border.all(color: Colors.grey),
//         //               borderRadius: BorderRadius.circular(8),
//         //             ),
//         //             child: const Text(
//         //               "Subscribe to a Course",
//         //               textAlign: TextAlign.center,
//         //               style: TextStyle(fontSize: 16),
//         //             ),
//         //           ),
//         //           onTap: () {
//         //             Navigator.pushReplacement(
//         //                 context,
//         //                 MaterialPageRoute(
//         //                   builder: (context) =>
//         //                       SubscribedCoursesPage(token: token),
//         //                 ));
//         //           },
//         //         ),
//         //       ),
//         //     ],
//         //   ),
//         // ),
//          drawer: DrowerPage(token: token),
//         body: Consumer<SubscribedCoursesViewModel>(
//           builder: (context, viewModel, child) {
//             if (viewModel.isLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (viewModel.errorMessage != null) {
//               return Center(
//                 child: Text(
//                   viewModel.errorMessage!,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               );
//             }

//             if (viewModel.courseSubscriptions.isEmpty) {
//               return const Center(child: Text("No subscribed courses"));
//             }

//             return ListView.builder(
//               itemCount: viewModel.courseSubscriptions.length,
//               itemBuilder: (context, index) {
//                 final CourseSubscription subscription =
//                     viewModel.courseSubscriptions[index];

//                 return Card(
//                   elevation: 4,
//                   margin: const EdgeInsets.all(8),
//                   child: ListTile(
//                     title: Text("Course: ${subscription.courseName}"),
//                     subtitle: Text(
//                       "Section: ${subscription.sectionName} - Lecturer: ${subscription.lecturer}",
//                     ),
//                     trailing: Text(subscription.collegeName),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CourseDetailPage(
//                             courseDetails:
//                                 subscription, // Pass the model object
//                             token: token,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:projectfeeds/views/drawer.dart';
import 'package:projectfeeds/views/course_detail_page.dart';
import 'package:projectfeeds/models/course_subscription_model.dart';

class SubscribedCoursesPage extends StatefulWidget {
  final String token;

  const SubscribedCoursesPage({super.key, required this.token});

  @override
  _SubscribedCoursesPageState createState() => _SubscribedCoursesPageState();
}

class _SubscribedCoursesPageState extends State<SubscribedCoursesPage> {
  List<CourseSubscription> courseSubscriptions = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchSubscriptions();
  }

  Future<void> fetchSubscriptions() async {
    try {
      // Simulate fetching data or replace with an API call.
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        courseSubscriptions = []; // Replace with your API response data.
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = "Failed to load subscriptions.";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subscribed Courses"),
      ),
      drawer: DrowerPage(token: widget.token),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : courseSubscriptions.isEmpty
                  ? const Center(child: Text("No subscribed courses"))
                  : ListView.builder(
                      itemCount: courseSubscriptions.length,
                      itemBuilder: (context, index) {
                        final subscription = courseSubscriptions[index];
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.all(8),
                          child: ListTile(
                            title: Text("Course: ${subscription.courseName}"),
                            subtitle: Text(
                              "Section: ${subscription.sectionName} - Lecturer: ${subscription.lecturer}",
                            ),
                            trailing: Text(subscription.collegeName),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CourseDetailPage(
                                    courseDetails: subscription,
                                    token: widget.token,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
    );
  }
}
