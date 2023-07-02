import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Common Files/constants.dart';
import '../Widgets/confirm_logout_alertbox.dart';
import '../Widgets/custom_app_bar.dart';
import '../Widgets/side_drawer.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static get routeName => '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<bool> _onBackPressed() async {
    var shouldLogout = await showDialog(
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
    return shouldLogout;
  }

  void logout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Constants.whiteColor,
      ),
    );
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          context: context,
          title: 'Home Screen',
        ),
        drawer: const MyDrawer(),
        body: Container(
          decoration: const BoxDecoration(
            // Add a background image
            image: DecorationImage(
              image: AssetImage('assets/home_screen_bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(),
          ),
        ),
      ),
    );
  }
}
