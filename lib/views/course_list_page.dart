// import 'package:flutter/material.dart';
// import 'package:projectfeeds/view_models/course_view_model.dart';
// import 'package:projectfeeds/views/Post_page.dart';
// import 'package:projectfeeds/views/drawer.dart';
// import 'package:provider/provider.dart';

// class CourseList extends StatelessWidget {
//   final String token;

//   const CourseList({super.key, required this.token});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => CourseViewModel(token: token)
//         ..loadCourses()
//         ..loadSubscriptions(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Courses"),
//         ),
//         drawer: DrowerPage(token: token),
//         body: Consumer<CourseViewModel>(
//           builder: (context, viewModel, child) {
//             if (viewModel.isLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (viewModel.courses.isEmpty) {
//               return const Center(child: Text("No courses available"));
//             }

//             return ListView.builder(
//               itemCount: viewModel.courses.length,
//               itemBuilder: (context, index) {
//                 final course = viewModel.courses[index];
//                 final courseId = course['id'];
//                 final courseSections = viewModel.sections[courseId] ?? [];

//                 return Card(
//                   elevation: 4,
//                   margin: const EdgeInsets.all(8),
//                   child: ExpansionTile(
//                     title: Text(course['name']),
//                     subtitle: Text("College: ${course['college']}"),
//                     onExpansionChanged: (expanded) {
//                       if (expanded && viewModel.sections[courseId] == null) {
//                         viewModel.loadSections(courseId);
//                       }
//                     },
//                     children: courseSections.isEmpty
//                         ? [
//                             const Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: Text("No sections available."),
//                             ),
//                           ]
//                         : courseSections.map((section) {
//                             final sectionId = section['id'];
//                             final isSubscribed = viewModel.sectionSubscriptions
//                                 .containsKey(sectionId);

//                             return ListTile(
//                               title: Text("Section: ${section['name']}"),
//                               subtitle:
//                                   Text("Lecturer: ${section['lecturer']}"),
//                               trailing: IconButton(
//                                 icon: Icon(
//                                   isSubscribed
//                                       ? Icons.remove_circle
//                                       : Icons.add_circle,
//                                   color:
//                                       isSubscribed ? Colors.red : Colors.green,
//                                 ),
//                                 onPressed: () {
//                                   if (isSubscribed) {
//                                     // Unsubscribe if already subscribed
//                                     viewModel.unsubscribe(courseId, sectionId);
//                                   } else {
//                                     // Subscribe if not subscribed
//                                     viewModel.subscribe(courseId, sectionId);
//                                   }
//                                 },
//                               ),
//                                onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => PostPage(
//                                       courseId: courseId,
//                                       sectionId: sectionId,
//                                       token: token,
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           }).toList(),
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
import 'package:projectfeeds/view_models/course_view_model.dart';
import 'package:projectfeeds/views/Post_page.dart';
import 'package:projectfeeds/views/drawer.dart';

class CourseList extends StatefulWidget {
  final String token;

  const CourseList({super.key, required this.token});

  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  late CourseViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = CourseViewModel(token: widget.token);
    _viewModel.loadCourses();
    _viewModel.loadSubscriptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Courses"),
      ),
      drawer: DrowerPage(token: widget.token),
      body: Builder(
        builder: (context) {
          if (_viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_viewModel.courses.isEmpty) {
            return const Center(child: Text("No courses available"));
          }

          return ListView.builder(
            itemCount: _viewModel.courses.length,
            itemBuilder: (context, index) {
              final course = _viewModel.courses[index];
              final courseId = course['id'];
              final courseSections = _viewModel.sections[courseId] ?? [];

              return Card(
                elevation: 4,
                margin: const EdgeInsets.all(8),
                child: ExpansionTile(
                  title: Text(course['name']),
                  subtitle: Text("College: ${course['college']}"),
                  onExpansionChanged: (expanded) {
                    if (expanded && _viewModel.sections[courseId] == null) {
                      _viewModel.loadSections(courseId);
                    }
                  },
                  children: courseSections.isEmpty
                      ? [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("No sections available."),
                          ),
                        ]
                      : courseSections.map((section) {
                          final sectionId = section['id'];
                          final isSubscribed =
                              _viewModel.sectionSubscriptions.containsKey(sectionId);

                          return ListTile(
                            title: Text("Section: ${section['name']}"),
                            subtitle: Text("Lecturer: ${section['lecturer']}"),
                            trailing: IconButton(
                              icon: Icon(
                                isSubscribed
                                    ? Icons.remove_circle
                                    : Icons.add_circle,
                                color: isSubscribed ? Colors.red : Colors.green,
                              ),
                              onPressed: () {
                                if (isSubscribed) {
                                  // Unsubscribe if already subscribed
                                  _viewModel.unsubscribe(courseId, sectionId);
                                } else {
                                  // Subscribe if not subscribed
                                  _viewModel.subscribe(courseId, sectionId);
                                }
                              },
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PostPage(
                                    courseId: courseId,
                                    sectionId: sectionId,
                                    token: widget.token,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
