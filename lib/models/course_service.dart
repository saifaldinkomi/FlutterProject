// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'subscription.dart';

// class CourseService {
//   final String subscriptionsUrl = "http://feeds.ppu.edu/api/v1/subscriptions";

//   Future<List<Subscription>> fetchSubscriptions(String token) async {
//     try {
//       final response = await http.get(
//         Uri.parse(subscriptionsUrl),
//         headers: {"Authorization": token},
//       );
//       if (response.statusCode == 200) {
//         final dynamic data = jsonDecode(response.body);
//         if (data is Map<String, dynamic> && data['subscriptions'] != null) {
//           List<Subscription> subscriptions = [];
//           for (var sub in data['subscriptions']) {
//             subscriptions.add(Subscription.fromJson(sub));
//           }
//           return subscriptions;
//         } else {
//           throw Exception("No subscriptions found.");
//         }
//       } else {
//         throw Exception('Failed to fetch subscriptions. Status Code: ${response.statusCode}');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'subscription.dart';

class CourseService {
  final String subscriptionsUrl = "http://feeds.ppu.edu/api/v1/subscriptions";

  Future<List<Subscription>> fetchSubscriptions(String token) async {
    try {
      final response = await http.get(
        Uri.parse(subscriptionsUrl),
        headers: {"Authorization": token},
      );
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        if (data is Map<String, dynamic> && data['subscriptions'] != null) {
          List<Subscription> subscriptions = [];
          for (var sub in data['subscriptions']) {
            subscriptions.add(Subscription.fromJson(sub));
          }
          return subscriptions;
        } else {
          throw Exception("No subscriptions found.");
        }
      } else {
        throw Exception('Failed to fetch subscriptions. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
