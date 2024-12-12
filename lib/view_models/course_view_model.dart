// course_view_model.dart

import 'package:flutter/material.dart';
// import 'package:projectfeeds/course_model.dart';
import 'package:projectfeeds/models/course_model.dart';

class CourseViewModel extends ChangeNotifier {
  final CourseModel courseModel;
  final String token;
  bool isLoading = false;
  List<dynamic> courses = [];
  Map<int, List<dynamic>> sections = {};
  Map<int, Map<String, dynamic>> subscriptions = {};

  CourseViewModel({required this.token, required this.courseModel});

  Future<void> fetchCourses() async {
    isLoading = true;
    notifyListeners();

    try {
      courses = await courseModel.fetchCourses(token);
      notifyListeners();
    } catch (e) {
      print("Error fetching courses: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSubscriptions() async {
    try {
      subscriptions = await courseModel.fetchSubscriptions(token);
      notifyListeners();
    } catch (e) {
      print("Error fetching subscriptions: $e");
    }
  }

  Future<void> fetchSections(int courseId) async {
    try {
      final sectionsForCourse = await courseModel.fetchSections(courseId, token);
      sections[courseId] = sectionsForCourse;
      notifyListeners();
    } catch (e) {
      print("Error fetching sections: $e");
    }
  }

  Future<void> subscribe(int courseId, int sectionId) async {
    try {
      await courseModel.subscribeToSection(courseId, sectionId, token);
      subscriptions[courseId] = {
        'section_id': sectionId,
      };
      notifyListeners();
    } catch (e) {
      print("Error subscribing: $e");
    }
  }

  Future<void> unsubscribe(int courseId, int sectionId) async {
    try {
      await courseModel.unsubscribeFromSection(courseId, sectionId, token);
      subscriptions.remove(courseId);
      notifyListeners();
    } catch (e) {
      print("Error unsubscribing: $e");
    }
  }
}
