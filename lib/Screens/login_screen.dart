// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:my_flutter_app/Widgets/confirm_exit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:my_flutter_app/Screens/home_screen.dart';

import '../Common Files/global_functions.dart';
import '../Database/database.dart';
import '../Services/provider_service.dart';
import '../Widgets/flush_bar.dart';
import '../Widgets/login_first_alertbox.dart';
import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LocalAuthentication _localAuth = LocalAuthentication();
  final sharedPreferences = SharedPreferences.getInstance();
  String lastLoggedInEmail = '';

  Future<bool> _onBackPressed() async {
    var shouldExit = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: const ExitConfirmationDialog(),
        );
      },
    );
    if (shouldExit == true) {
      exit(0);
    }
    return shouldExit;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
    _getLastLoggedInEmail();
  }

  Future<void> _getLastLoggedInEmail() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final email = sharedPreferences.getString('lastLoggedInEmail');
    lastLoggedInEmail = email ?? '';
    setState(() {});
  }

  void _authenticateWithFingerprint(BuildContext context) async {
    bool authenticated = false;
    final user = await DatabaseHelper.getUserByEmail(lastLoggedInEmail);
    if (user != null) {
      try {
        authenticated = await _localAuth.authenticate(
          localizedReason: 'Authenticate with fingerprint',
        );
      } catch (e) {
        // Handle any exceptions
        if (kDebugMode) {
          print('Error authenticating: $e');
        }
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const LoginFirstAlertDialog();
        },
      );
    }

    if (authenticated) {
      // Authentication succeeded, navigate to the home screen or perform any desired action

      final String? username = user?.firstName;
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setLoggedInEmail(lastLoggedInEmail);
      userProvider.setLoggedInUserName(username!);
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } else {
      // Authentication failed, show an error message or perform any desired action
      (user != null)
          ? showFlushbar('Authentication Failed', context)
          : Container();
    }
  }

  void _performLogin(BuildContext context) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final email = _emailController.text;
    final password = _passwordController.text;

    // Validate the email and password against the database
    final user = await DatabaseHelper.getUserByEmail(email);
    final String? username = user?.firstName;
    if (user != null && user.password == password) {
      // Login successful, navigate to the home screen or perform any desired action
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setLoggedInEmail(email);
      userProvider.setLoggedInUserName(username!);
      await sharedPreferences.setString('lastLoggedInEmail', email);
    } else {
      // Login failed, show an error message or perform any desired action
      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
        content: Padding(
          padding: const EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Invalid email or password!',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ],
              ),
              IconButton(
                color: Colors.white,
                icon: const Icon(Icons.close),
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ],
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: GestureDetector(
        onTap: () {
          // Unfocus text fields when tapped outside
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Login',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/pattern4.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.end, // Align objects at the bottom
                  children: [
                    //! Login Email TextFormField
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
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
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: _emailController.text.isEmpty
                                ? Colors.green
                                : (isValidEmail(_emailController.text)
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
                          Icons.email,
                          color: Colors.white,
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!isValidEmail(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onChanged: (_) {
                        setState(() {});
                      },
                    ),

                    const SizedBox(height: 16.0),

                    //! Login Password TextFormField
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.green,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.green,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.green,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          child: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        // Define your password validation rules here
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        if (!value.contains(RegExp(r'[A-Z]'))) {
                          return 'Password must contain at least one uppercase letter';
                        }
                        if (!value
                            .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                          return 'Password must contain at least one special character';
                        }
                        // Return null if the password is valid
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    //! Login Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _performLogin(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              const Color.fromARGB(255, 152, 178, 23),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'Register as a ',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: 'New User',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 152, 178, 23),
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).pushNamed(
                                        RegistrationScreen.routeName);
                                  },
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: const Text('Forgot Password ?'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    const SizedBox(height: 10.0),
                    ElevatedButton.icon(
                      onPressed: () => _authenticateWithFingerprint(context),
                      icon: const Icon(Icons.fingerprint),
                      label: const Text('Login with Fingerprint'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor:
                            const Color.fromARGB(255, 152, 178, 23),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
