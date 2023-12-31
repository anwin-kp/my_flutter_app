import 'package:flutter/material.dart';
import '../Database/database.dart';
import '../Models/user_model.dart';
import '../Widgets/custom_app_bar.dart';
import '../Widgets/side_drawer.dart';
import 'edit_profile.dart';

class ProfilePageScreen extends StatefulWidget {
  final String? email;
  const ProfilePageScreen({Key? key, required this.email}) : super(key: key);
  static get routeName => '/profile_screen';
  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: DatabaseHelper.getUserByEmail(widget.email!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const Text('User not found');
        } else {
          final user = snapshot.data!;
          final textStyle = TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyMedium!.color,
          );
          final borderColor = Theme.of(context).textTheme.bodyMedium!.color;

          return Scaffold(
            appBar: CustomAppBar(
              context: context,
              title: 'Profile',
            ),
            drawer: const MyDrawer(),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 30, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: user.firstName,
                    readOnly: true,
                    style: textStyle,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: borderColor!,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: borderColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: borderColor,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: textStyle.color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: user.lastName,
                    readOnly: true,
                    style: textStyle,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: borderColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: borderColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: borderColor,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: textStyle.color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: user.email,
                    readOnly: true,
                    style: textStyle,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: borderColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: borderColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: borderColor,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: textStyle.color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: user.mobileNumber,
                    readOnly: true,
                    style: textStyle,
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: borderColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: borderColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: borderColor,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: textStyle.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => EditProfileScreen(
                            user: user,
                          )),
                );
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.edit),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        }
      },
    );
  }
}
