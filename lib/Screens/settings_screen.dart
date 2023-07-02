import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_flutter_app/Widgets/confirm_delete_user.dart';
import 'package:provider/provider.dart';

import '../Database/database.dart';
import '../Services/provider_service.dart';
import '../Services/theme_provider.dart';
import '../Widgets/custom_app_bar.dart';
import '../Widgets/side_drawer.dart';
import 'login_screen.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static get routeName => '/settings_screen';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? email;
  Future<void> logout() async {
    await DatabaseHelper.deleteUserByEmail(email!).then((value) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool shouldDeleteUser = false;

    email = Provider.of<UserProvider>(context).loggedInEmail;
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: 'Settings',
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'App Theme',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SwitchListTile(
              title: Text(
                'Dark Mode',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),
              value: themeProvider.isDarkModeEnabled,
              onChanged: (value) {
                themeProvider.setDarkMode(value);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 40,
        margin: const EdgeInsets.fromLTRB(15, 15, 15, 25),
        child: ElevatedButton(
          onPressed: () async {
            shouldDeleteUser = await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext dialogContext) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: const DeleteUserConfirmationDialog(),
                );
              },
            );
            if (shouldDeleteUser == true) {
              logout();
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            backgroundColor: Colors.red,
            elevation: 0, // Set the button color to red
          ),
          child: const Text(
            'Delete User',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
