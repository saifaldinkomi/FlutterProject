// course_list.dart

import 'package:flutter/material.dart';
import 'package:projectfeeds/models/course_model.dart';
import 'package:projectfeeds/view_models/course_view_model.dart';
import 'package:provider/provider.dart';
// import 'package:projectfeeds/course_view_model.dart';

class CourseList extends StatelessWidget {
  final String token;

  const CourseList({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CourseViewModel(
        token: token,
        courseModel: CourseModel(),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text("Courses")),
        body: Consumer<CourseViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return viewModel.courses.isEmpty
                ? const Center(child: Text("No courses available"))
                : ListView.builder(
                    itemCount: viewModel.courses.length,
                    itemBuilder: (context, index) {
                      final course = viewModel.courses[index];
                      final courseId = course['id'];
                      final courseSections = viewModel.sections[courseId] ?? [];

                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.all(8),
                        child: ExpansionTile(
                          title: Text(course['name']),
                          subtitle: Text("College: ${course['college']}"),
                          onExpansionChanged: (expanded) {
                            if (expanded && viewModel.sections[courseId] == null) {
                              viewModel.fetchSections(courseId);
                            }
                          },
                          children: courseSections.isEmpty
                              ? [const Padding(padding: EdgeInsets.all(8.0), child: Text("No sections available."))]
                              : courseSections.map((section) {
                                  final sectionId = section['id'];
                                  final isSubscribed = viewModel.subscriptions[courseId]?['section_id'] == sectionId;

                                  return ListTile(
                                    title: Text("Section: ${section['name']}"),
                                    subtitle: Text("Lecturer: ${section['lecturer']}"),
                                    trailing: IconButton(
                                      icon: Icon(
                                        isSubscribed ? Icons.check_circle : Icons.cancel,
                                        color: isSubscribed ? Colors.green : Colors.red,
                                      ),
                                      onPressed: () => isSubscribed
                                          ? viewModel.unsubscribe(courseId, sectionId)
                                          : viewModel.subscribe(courseId, sectionId),
                                    ),
                                  );
                                }).toList(),
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
