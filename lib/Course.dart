import 'dart:convert'; // For JSON decoding
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projectfeeds/courseDetails.dart';
import 'package:projectfeeds/post.dart';

class CourseList extends StatefulWidget {
  final String token;

  const CourseList({super.key, required this.token});

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  final String courseUrl = "http://feeds.ppu.edu/api/v1/courses";
  final String subscriptionsUrl = "http://feeds.ppu.edu/api/v1/subscriptions";

  List<dynamic> courses = [];
  Map<int, List<dynamic>> sections = {};
  Map<int, Map<String, dynamic>> courseSubscriptions = {};

  bool isLoading = false;

  Future<void> getCourses() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(courseUrl),
        headers: {"Authorization": widget.token},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          courses = data['courses'];
        });
      } else {
        print("response.statusCode: ${response.statusCode}");
      }
    } catch (e) {
      print('Error fetching courses: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getSections(int courseId) async {
    try {
      final response = await http.get(
        Uri.parse("$courseUrl/$courseId/sections"),
        headers: {"Authorization": widget.token},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          sections[courseId] = data['sections'];
        });
      } else {
        print('Failed to fetch sections for course $courseId');
      }
    } catch (e) {
      print('Error fetching sections for course $courseId: $e');
    }
  }

  Future<void> checkSubscriptions() async {
    try {
      final response = await http.get(
        Uri.parse(subscriptionsUrl),
        headers: {"Authorization": widget.token},
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

        setState(() {
          courseSubscriptions = subscriptions;
        });
      } else {
        print(
            'Failed to fetch subscriptions. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching subscriptions: $e');
    }
  }

  Future<void> subscribeSection(int courseId, int sectionId) async {
    final String url =
        "http://feeds.ppu.edu/api/v1/courses/$courseId/sections/$sectionId/subscribe";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Authorization": widget.token},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          courseSubscriptions[courseId] = {
            'section_id': sectionId,
            'subscription_id': data['subscription_id'],
          };
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Subscribed successfully')),
        );
      } else {
        print('Failed to subscribe. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error subscribing: $e');
    }
  }

  Future<void> unsubscribeSection(int courseId, int sectionId) async {
    final subscriptionId = courseSubscriptions[courseId]?['subscription_id'];
    if (subscriptionId == null) return;

    final String url =
        "http://feeds.ppu.edu/api/v1/courses/$courseId/sections/$sectionId/subscribe/$subscriptionId";

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {"Authorization": widget.token},
      );

      if (response.statusCode == 200) {
        setState(() {
          courseSubscriptions.remove(courseId); // Remove from local state
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unsubscribed successfully')),
        );
      } else {
        print('Failed to unsubscribe. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error unsubscribing: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getCourses();
    checkSubscriptions(); // Check existing subscriptions
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Courses"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : courses.isEmpty
              ? const Center(child: Text("No courses available"))
              : ListView.builder(
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];
                    final courseId = course['id'];
                    final courseSections = sections[courseId] ?? [];
                    final subscription =
                        courseSubscriptions[courseId]; // Current subscription

                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.all(8),
                      child: ExpansionTile(
                        title: Text(course['name']),
                        subtitle: Text("College: ${course['college']}"),
                        onExpansionChanged: (expanded) {
                          if (expanded && sections[courseId] == null) {
                            getSections(courseId);
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
                                    subscription?['section_id'] == sectionId;

                                return ListTile(
                                  title: Text("Section: ${section['name']}"),
                                  subtitle:
                                      Text("Lecturer: ${section['lecturer']}"),
                                  trailing: IconButton(
                                    icon: Icon(
                                      isSubscribed
                                          ? Icons.check_circle
                                          : Icons.cancel,
                                      color: isSubscribed
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    onPressed: () => courseSubscriptions
                                            .containsKey(courseId)
                                        ? unsubscribeSection(
                                            courseId, sectionId)
                                        : subscribeSection(courseId, sectionId),
                                  ),
                                  onTap: () {
                                    // Navigate to detailed course screen
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PostPage(
                                            courseId: courseId,
                                            sectionId: sectionId,
                                            token: widget.token,
                                          ),
                                        ));
                                  },
                                );
                              }).toList(),
                      ),
                    );
                  },
                ),
    );
  }
}
