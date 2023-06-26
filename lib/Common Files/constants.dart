import 'package:flutter/material.dart';

class Constants {
  Constants._();

  //! TEXT
  static const String loginText = 'LogIn';

  //IMAGE ASSETS PATH
  static const String logoImageSrc = "assets/logos/logo_1.png";

  //Colors
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color redColor = Colors.red;
  static const Color greenColor = Colors.green;
  static const Color navBarBgColor = Color.fromARGB(255, 213, 189, 175);
}

//valueNotifier
final userIdNotifier = ValueNotifier<int>(0);
