import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projectfeeds/Course.dart';
import 'package:projectfeeds/courseDetails.dart';

class SubscribedCoursesPage extends StatefulWidget {
  final String token;

  const SubscribedCoursesPage({super.key, required this.token});

  @override
  State<SubscribedCoursesPage> createState() => SubscribedCoursesPageState();
}

class SubscribedCoursesPageState extends State<SubscribedCoursesPage> {
  final String subscriptionsUrl = "http://feeds.ppu.edu/api/v1/subscriptions";
  List<Map<String, dynamic>> courseSubscriptions = [];
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchSubscriptions();
  }

  Future<void> fetchSubscriptions() async {
    try {
      final response = await http.get(
        Uri.parse(subscriptionsUrl),
        headers: {"Authorization": widget.token},
      );

      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);

        if (data is Map<String, dynamic> && data['subscriptions'] != null) {
          List<Map<String, dynamic>> subscriptions = [];
          for (var sub in data['subscriptions']) {
            subscriptions.add({
              'id': sub['id'],
              'course_name': sub['course'],
              'section_name': sub['section'],
              'lecturer': sub['lecturer'],
              'college_name':
                  "College of IT", // Replace with API data if available
              'subscription_date': sub['subscription_date'],
            });
          }

          setState(() {
            courseSubscriptions = subscriptions;
            isLoading = false;  
          });
        } else {
          print('No subscriptions found!');
          setState(() {
            courseSubscriptions = [];
            isLoading = false;
          });
        }
      } else {
        print(
            'Failed to fetch subscriptions. Status Code: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching subscriptions: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subscribed Courses"),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              // Navigate to the SubscribedCoursesPage
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CourseList(token: widget.token)));
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
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
                        title: Text("Course: ${subscription['course_name']}"),
                        subtitle: Text(
                            "Section: ${subscription['section_name']} - Lecturer: ${subscription['lecturer']}"),
                        trailing: Text(subscription['college_name']),
                        onTap: () {
                          // Navigate to detailed course screen
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CourseDetailPage(
                                        courseDetails: subscription,
                                      )));
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
