import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app/Screens/home_screen.dart';
import 'package:my_flutter_app/Screens/settings_screen.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/about_screen.dart';
import '../Screens/login_screen.dart';
import '../Screens/profile_screen.dart';
import '../Services/provider_service.dart';
import 'confirm_logout_alertbox.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  File? _imageFile; // Variable to store the selected image file
  bool _isImageChanged = false;
  bool shouldLogout = false;

  @override
  void initState() {
    super.initState();
    _loadImageFromStorage(); // Load the stored image file on initialization
  }

  Future<void> _loadImageFromStorage() async {
    final preferences = await SharedPreferences.getInstance();
    final imagePath = preferences.getString('imagePath');

    if (imagePath != null) {
      setState(() {
        _imageFile = File(imagePath);
        _isImageChanged = true;
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/selected_image.jpg';
      final pickedFile = File(pickedImage.path);

      await pickedFile.copy(imagePath);

      final preferences = await SharedPreferences.getInstance();
      preferences.setString('imagePath', imagePath);

      setState(() {
        _imageFile = File(imagePath);
        _isImageChanged = true;
      });
    }
  }

  void logout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mock data for demonstration purposes

    String? userEmail = Provider.of<UserProvider>(context).loggedInEmail;
    String? userName = Provider.of<UserProvider>(context).loggedInUserName;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(16.0),
        bottom: Radius.circular(16.0),
      ),
      child: SizedBox(
        width: 230, // Adjust the width as needed
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 83, 83, 82),
                ),
                child: DrawerHeader(
                  padding: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            _pickImage(); // Call the image picker function
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: _isImageChanged &&
                                    _imageFile != null
                                ? FileImage(_imageFile!)
                                    as ImageProvider<Object>?
                                : const AssetImage('assets/user_avatar.png'),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          userName!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          userEmail!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
                title: Text(
                  'Profile',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePageScreen(email: userEmail),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(SettingsPage.routeName);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.info,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
                title: Text(
                  'About',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutPageScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.help,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
                title: Text(
                  'Help & Support',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                ),
                onTap: () {
                  // Handle navigation to help and support
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                ),
                onTap: () async {
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
              // Add more ListTiles for additional menu items
            ],
          ),
        ),
      ),
    );
  }
}
