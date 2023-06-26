import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Common Files/constants.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static get routeName => '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Constants.whiteColor,
      ),
    );
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Home Screen',
          style: TextStyle(
            color: Constants.blackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white70,
        actions: [
          IconButton(
            onPressed: () {
              // Perform logout functionality here
              Navigator.pushNamedAndRemoveUntil(
                context,
                LoginScreen.routeName,
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 83, 83, 82),
              ),
              child: Text(
                'Navigation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Handle navigation to item 1
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Handle navigation to item 2
              },
            ),
            // Add more ListTiles for additional menu items
          ],
        ),
      ),
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
    );
  }
}
