import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginModel {
  final String loginUrl = "http://feeds.ppu.edu/api/login";

  Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        dynamic jsonObject = jsonDecode(response.body);
        if (jsonObject['status'] == 'success') {
          return jsonObject['session_token'];
        }
      }
      return null;
    } catch (e) {
      throw Exception('Error logging in: $e');
    }
  }
}
