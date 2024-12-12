import 'package:flutter/material.dart';
import '../models/subscription.dart';

class CourseItemWidget extends StatelessWidget {
  final Subscription subscription;

  const CourseItemWidget({super.key, required this.subscription});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text("Course: ${subscription.courseName}"),
        subtitle: Text(
            "Section: ${subscription.sectionName} - Lecturer: ${subscription.lecturer}"),
        trailing: Text(subscription.collegeName),
        onTap: () {
          // Navigate to detailed course screen
        },
      ),
    );
  }
}
