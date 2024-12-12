// import 'package:flutter/material.dart';
// import '../models/course_service.dart';
// import '../models/subscription.dart';

// class SubscriptionViewModel extends ChangeNotifier {
//   final CourseService _courseService;
//   List<Subscription> courseSubscriptions = [];
//   bool isLoading = false;

//   SubscriptionViewModel(this._courseService);

//   Future<void> fetchSubscriptions(String token) async {
//     try {
//       isLoading = true;
//       notifyListeners();

//       courseSubscriptions = await _courseService.fetchSubscriptions(token);
//       isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       isLoading = false;
//       notifyListeners();
//       print("Error fetching subscriptions: $e");
//     }
//   }
// }
import 'package:flutter/material.dart';
import '../models/course_service.dart';
import '../models/subscription.dart';

class SubscriptionViewModel extends ChangeNotifier {
  final CourseService _courseService;
  List<Subscription> courseSubscriptions = [];
  bool isLoading = false;

  SubscriptionViewModel(this._courseService);

  Future<void> fetchSubscriptions(String token) async {
    try {
      isLoading = true;
      notifyListeners();

      courseSubscriptions = await _courseService.fetchSubscriptions(token);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print("Error fetching subscriptions: $e");
    }
  }
}
