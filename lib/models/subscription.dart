class Subscription {
  final String id;
  final String courseName;
  final String sectionName;
  final String lecturer;
  final String collegeName;
  final String subscriptionDate;

  Subscription({
    required this.id,
    required this.courseName,
    required this.sectionName,
    required this.lecturer,
    required this.collegeName,
    required this.subscriptionDate,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      courseName: json['course'],
      sectionName: json['section'],
      lecturer: json['lecturer'],
      collegeName: "College of IT",  // Fixed value
      subscriptionDate: json['subscription_date'],
    );
  }
}
