// ignore_for_file: unused_element, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import 'package:my_flutter_app/Screens/home_screen.dart';

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

  // Rest of the LoginScreen class code...

  void _authenticateWithFingerprint(BuildContext context) async {
    bool authenticated = false;
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

    if (authenticated) {
      // Authentication succeeded, navigate to the home screen or perform any desired action
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } else {
      // Authentication failed, show an error message or perform any desired action
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Authentication Failed'),
          content: const Text('Please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  // Rest of the LoginScreen class code...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
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
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle login logic here
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    if (kDebugMode) {
                      print('Email: $email\nPassword: $password');
                    }
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routeName);
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              const SizedBox(height: 5.0),
              TextButton(
                onPressed: () {
                  // Handle forgot password logic here
                  if (kDebugMode) {
                    print('Forgot password');
                  }
                  // You can navigate to a forgot password screen or show a password reset dialog
                },
                child: const Text('Forgot Password?'),
              ),
              const SizedBox(height: 5.0),
              TextButton(
                onPressed: () {
                  // Handle register logic here
                  if (kDebugMode) {
                    print('Register as a new user');
                  }
                  // You can navigate to a registration screen or show a registration dialog
                },
                child: const Text('Register as New User'),
              ),
              ElevatedButton.icon(
                onPressed: () => _authenticateWithFingerprint(context),
                icon: const Icon(Icons.fingerprint),
                label: const Text('Login with Fingerprint'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue, // Set the button's text color
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
