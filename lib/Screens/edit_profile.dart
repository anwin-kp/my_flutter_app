import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/Screens/profile_screen.dart';

import '../Common Files/global_functions.dart';
import '../Database/database.dart';
import '../Models/user_model.dart';
import '../Widgets/flush_bar.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/edit_profile_screen';
  final User? user;
  const EditProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? userEmail;
  User? _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
    _fetchUserProfile();
  }

  void _fetchUserProfile() async {
    final user = widget.user;

    if (user != null) {
      setState(() {
        _currentUser = user;
        _firstNameController.text = user.firstName;
        _lastNameController.text = user.lastName;
        _mobileNumberController.text = user.mobileNumber;
        _emailController.text = user.email;
      });
    }
  }

  void navigateToProfile() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ProfilePageScreen(
          email: _currentUser!.email,
        ),
      ),
    );
  }

  void _performUpdate(BuildContext context) async {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final mobileNumber = _mobileNumberController.text;

    // Update the user in the database
    final updatedUser = _currentUser!.copyWith(
      firstName: firstName,
      lastName: lastName,
      mobileNumber: mobileNumber,
    );

    await DatabaseHelper.updateUser(updatedUser).then((value) {
      if (kDebugMode) {
        print("User Updated in the database");
      }

      showDoneFlushbar('Profile updated successfully.', context);
    });
    navigateToProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.transparent,
        leadingWidth: 500,
        leading: Row(
          children: [
            IconButton(
              enableFeedback: false,
              icon: Icon(
                Icons.arrow_back_outlined,
                color: Theme.of(context).textTheme.displayLarge!.color,
              ),
              onPressed: () {
                FocusScope.of(context).unfocus();
                Navigator.of(context).pop();
              },
            ),
            Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 25,
                color: Theme.of(context).textTheme.displayLarge!.color,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/pattern5.jpg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(
            top: AppBar().preferredSize.height +
                MediaQuery.of(context).padding.top +
                10,
          ),
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _firstNameController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: _firstNameController.text.isEmpty
                            ? Colors.green
                            : (isValidFirstName(_firstNameController.text)
                                ? Colors.green
                                : Colors.red),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: _firstNameController.text.isEmpty
                            ? Colors.green
                            : (isValidFirstName(_firstNameController.text)
                                ? Colors.green
                                : Colors.red),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.green,
                      ),
                    ),
                    labelStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    if (!isValidFirstName(value)) {
                      return 'Please enter a valid first name';
                    }
                    return null;
                  },
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _lastNameController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: _lastNameController.text.isEmpty
                            ? Colors.green
                            : (isValidLastName(_lastNameController.text)
                                ? Colors.green
                                : Colors.red),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: _lastNameController.text.isEmpty
                            ? Colors.green
                            : (isValidLastName(_lastNameController.text)
                                ? Colors.green
                                : Colors.red),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.green,
                      ),
                    ),
                    labelStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    if (!isValidLastName(value)) {
                      return 'Please enter a valid last name';
                    }
                    return null;
                  },
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  enabled: false,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: _emailController.text.isEmpty
                            ? Colors.green
                            : (isValidEmail(_emailController.text)
                                ? Colors.green
                                : Colors.red),
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: _emailController.text.isEmpty
                            ? Colors.green
                            : (isValidEmail(_emailController.text)
                                ? Colors.green
                                : Colors.red),
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    labelStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _mobileNumberController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: _mobileNumberController.text.isEmpty
                            ? Colors.green
                            : (isValidMobileNumber(_mobileNumberController.text)
                                ? Colors.green
                                : Colors.red),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: _mobileNumberController.text.isEmpty
                            ? Colors.green
                            : (isValidMobileNumber(_mobileNumberController.text)
                                ? Colors.green
                                : Colors.red),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.green,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    labelStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    if (!isValidMobileNumber(value)) {
                      return 'Please enter a valid mobile number';
                    }
                    return null;
                  },
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _performUpdate(context);
                      }
                    },
                    child: const Text('Update Profile'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
