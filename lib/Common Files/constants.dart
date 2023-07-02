import 'package:flutter/material.dart';

class Constants {
  Constants._();

  //! TEXT
  static const String loginText = 'LogIn';
  static const String logoutText = 'Logout';
  static const String homeText = 'Home';
  static const String profileText = 'Profile';
  static const String aboutText = 'About';
  static const String yesText = 'Yes';
  static const String noText = 'No';
  static const String supportText = 'Support';
  static const String versionText = 'Version';
  static const String logoutConfirmationText = 'Confirm Logout';
  static const String areYouSureLogoutText = 'Are You Sure Want to Logout?';
  static const String currentVersionText = '1.0.0';
  //IMAGE ASSETS PATH
  static const String logoImageSrc = "assets/logos/logo_1.png";

  //Colors
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color textColor = Color.fromARGB(255, 48, 10, 97);
  static const Color redColor = Colors.red;
  static const Color greenColor = Colors.green;
  static const Color navBarBgColor = Color.fromARGB(255, 213, 189, 175);
  static const Color commonBgColor = Color.fromARGB(255, 228, 215, 207);
}

//valueNotifier
final userIdNotifier = ValueNotifier<int>(0);
