// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Common Files/constants.dart';

import '../Screens/login_screen.dart';
import 'confirm_logout_alertbox.dart';

//This is the side Navigation Bar in the homescreen
class SideNavBar extends StatefulWidget {
  const SideNavBar({super.key});

  @override
  State<SideNavBar> createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  bool shouldLogout = false;

  var size, height, width;
  bool isChargingActive = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Constants.commonBgColor,
      ),
    );
    final Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Drawer(
      backgroundColor: Constants.blackColor,
      width: width * 0.70,
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: <Widget>[
          DrawerHeader(
              padding: EdgeInsets.zero,
              decoration: const BoxDecoration(
                color: Constants.commonBgColor,
              ),
              child: Container(
                  color: Constants.blackColor,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.all(10)),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage("assets/logos/user.png"),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Anwin',
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "anwin.kp@gadgeon.com",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ))),
          //ListTiles that shows in the side navigation bar
          ListTile(
            leading: const Icon(
              Icons.home_outlined,
              color: Constants.greenColor,
            ),
            title: const Text(
              Constants.homeText,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(
              Icons.verified_user,
              color: Colors.white,
            ),
            title: const Text(
              Constants.profileText,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => {},
          ),
          ListTile(
              leading: const Icon(
                Icons.power_outlined,
                color: Colors.white,
              ),
              title: const Text(
                Constants.aboutText,
                style: TextStyle(color: Colors.white),
              ),
              onTap: () async {}),

          ListTile(
              leading: const Icon(
                Icons.wallet,
                color: Colors.white,
              ),
              title: const Text(
                'Wallet',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () async => {}),
          ListTile(
              leading: const Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
              ),
              title: const Text(
                'Support',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => {}),
          ListTile(
            leading: const Icon(
              Icons.account_box_outlined,
              color: Colors.white,
            ),
            title: const Text(
              'About',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(
              Icons.question_mark,
              color: Colors.white,
            ),
            title: const Text(
              'FAQ',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            title: const Text(
              Constants.logoutText,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () async => {
              shouldLogout = await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: const LogoutConfirmationDialog());
                },
              ),
              if (shouldLogout == true)
                {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false),
                },
            },
          ),
        ],
      ),
    );
  }
}
