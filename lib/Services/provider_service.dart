import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? loggedInEmail;
  String? loggedInUserName;
  void setLoggedInEmail(String email) {
    loggedInEmail = email;
    notifyListeners();
  }

  void setLoggedInUserName(String username) {
    loggedInUserName = username;
    notifyListeners();
  }
}
