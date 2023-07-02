import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../Common Files/constants.dart';

void showSnackBar(String value, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(value),
    duration: const Duration(milliseconds: 1300),
  ));
}

//FlushBar to show the error messages
Flushbar showFlushbar(String textToShow, BuildContext context) {
  return Flushbar(
    margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
    borderRadius: BorderRadius.circular(10),
    flushbarPosition: FlushbarPosition.TOP,
    message: textToShow,
    icon: Icon(
      Icons.info_outline,
      size: 28.0,
      color: Colors.red[300],
    ),
    duration: const Duration(seconds: 3),
    leftBarIndicatorColor: Colors.black26,
  )..show(context);
}

//FlushBar to show successful messages
Flushbar showDoneFlushbar(String textToShow, BuildContext context) {
  return Flushbar(
    margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
    borderRadius: BorderRadius.circular(10),
    flushbarPosition: FlushbarPosition.TOP,
    message: textToShow,
    icon: const Icon(
      Icons.done_all_outlined,
      size: 28.0,
      color: Color.fromARGB(226, 2, 255, 52),
    ),
    duration: const Duration(seconds: 3),
    leftBarIndicatorColor: Colors.black26,
  )..show(context);
}

Flushbar showDismissibleErrorFlushbar(
    String textToShow, BuildContext context, double height) {
  return Flushbar(
    animationDuration: const Duration(milliseconds: 300),
    forwardAnimationCurve: Curves.easeIn,
    reverseAnimationCurve: Curves.easeOut,
    isDismissible: true,
    duration: const Duration(seconds: 10),
    margin: EdgeInsets.fromLTRB(20, height * 0.25, 20, 0),
    borderRadius: BorderRadius.circular(10),
    flushbarPosition: FlushbarPosition.TOP,
    message: textToShow,
    mainButton: ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.close,
            color: Constants.whiteColor,
          ),
        )
      ],
    ),
    icon: const Icon(
      Icons.info_outline,
      size: 28.0,
      color: Colors.red,
    ),
    leftBarIndicatorColor: Colors.black26,
  )..show(context);
}
