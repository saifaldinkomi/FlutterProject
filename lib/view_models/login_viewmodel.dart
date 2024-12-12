import 'package:flutter/material.dart';
import 'package:projectfeeds/models/login_model.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginModel _loginModel = LoginModel();
  bool isLoading = false;

  Future<String?> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      String? token = await _loginModel.login(email, password);
      isLoading = false;
      notifyListeners();
      return token;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return null;
    }
  }
}
