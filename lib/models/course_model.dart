// course_model.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class CourseModel {
  final String courseUrl = "http://feeds.ppu.edu/api/v1/courses";
  final String subscriptionsUrl = "http://feeds.ppu.edu/api/v1/subscriptions";

  Future<List<dynamic>> fetchCourses(String token) async {
    final response = await http.get(
      Uri.parse(courseUrl),
      headers: {"Authorization": token},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['courses'];
    } else {
      throw Exception('Failed to load courses');
    }
  }

  Future<Map<int, Map<String, dynamic>>> fetchSubscriptions(String token) async {
    final response = await http.get(
      Uri.parse(subscriptionsUrl),
      headers: {"Authorization": token},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final Map<int, Map<String, dynamic>> subscriptions = {};

      for (var sub in data) {
        subscriptions[sub['course_id']] = {
          'section_id': sub['section_id'],
          'subscription_id': sub['id'],
        };
      }

      return subscriptions;
    } else {
      throw Exception('Failed to load subscriptions');
    }
  }

  Future<List<dynamic>> fetchSections(int courseId, String token) async {
    final response = await http.get(
      Uri.parse("$courseUrl/$courseId/sections"),
      headers: {"Authorization": token},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['sections'];
    } else {
      throw Exception('Failed to load sections');
    }
  }

  Future<void> subscribeToSection(int courseId, int sectionId, String token) async {
    final String url =
        "http://feeds.ppu.edu/api/v1/courses/$courseId/sections/$sectionId/subscribe";
    final response = await http.post(
      Uri.parse(url),
      headers: {"Authorization": token},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to subscribe to section');
    }
  }

  Future<void> unsubscribeFromSection(int courseId, int sectionId, String token) async {
    final String url =
        "http://feeds.ppu.edu/api/v1/courses/$courseId/sections/$sectionId/unsubscribe";
    final response = await http.delete(
      Uri.parse(url),
      headers: {"Authorization": token},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to unsubscribe from section');
    }
  }
}
