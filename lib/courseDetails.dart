import 'package:flutter/material.dart';

class CourseDetailPage extends StatelessWidget {
  final Map<String, dynamic> courseDetails;

  const CourseDetailPage({super.key, required this.courseDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseDetails['course_name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Course Name: ${courseDetails['course_name']}"),
            Text("Section: ${courseDetails['section_name']}"),
            Text("Lecturer: ${courseDetails['lecturer']}"),
            Text("College: ${courseDetails['college_name']}"),
            Text("Subscription Date: ${courseDetails['subscription_date']}"),
          ],
        ),
      ),
    );
  }
}
