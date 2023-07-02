// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:ui';

import 'package:flutter/material.dart';

import '../Common Files/constants.dart';
import '../Screens/login_screen.dart';
import 'confirm_logout_alertbox.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final String title;

  const CustomAppBar({
    Key? key,
    required this.context,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    bool shouldLogout = false;
    final Size size = MediaQuery.of(context).size;

    final width = size.width;
    final scaleFactor = width / 360;
    void logout() {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }

    return AppBar(
      leadingWidth: width * 1,
      backgroundColor: Theme.of(context).textTheme.displayMedium!.color,
      iconTheme: const IconThemeData(color: Constants.textColor),
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            color: Theme.of(context).textTheme.bodyMedium!.color,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.menu,
              size: 32 * scaleFactor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium!.color,
              fontWeight: FontWeight.bold,
              fontSize: 26.5 * scaleFactor,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 5.0, top: 5),
          child: IconButton(
            icon: const Icon(Icons.logout),
            color: Constants.textColor,
            onPressed: () async {
              shouldLogout = await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext dialogContext) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: const LogoutConfirmationDialog(),
                  );
                },
              );
              if (shouldLogout == true) {
                logout();
              }
            },
          ),
        )
      ],
    );
  }
}
