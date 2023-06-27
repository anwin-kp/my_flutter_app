// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:my_flutter_app/Models/user_model.dart';
import '../Common Files/global_functions.dart';
import '../Database/database.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = '/registration_screen';

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _validatePassword(String? value) {
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
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    // Return null if the password is valid
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your confirm password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _performRegistration(BuildContext context) async {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final email = _emailController.text;
    final mobileNumber = _mobileNumberController.text;
    final password = _passwordController.text;

    // Check if the email is already registered
    final user = await DatabaseHelper.getUserByEmail(email);

    if (user != null) {
      // Email is already registered, show an error message or perform any desired action
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Registration Failed'),
          content: const Text('Email is already registered.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Email is not registered, proceed with registration
      // Save user to the database
      final newUser = User(
        firstName: firstName,
        lastName: lastName,
        email: email,
        mobileNumber: mobileNumber,
        password: password,
      );

      await DatabaseHelper.insertUser(newUser);

      // Registration successful, show a success message or perform any desired action
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Registration Successful'),
          content: const Text('You have successfully registered.'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Registration'),
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
                  10),
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
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
                  const SizedBox(height: 16.0),
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
                              : (isValidMobileNumber(
                                      _mobileNumberController.text)
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: _mobileNumberController.text.isEmpty
                              ? Colors.green
                              : (isValidMobileNumber(
                                      _mobileNumberController.text)
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
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: _passwordController.text.isEmpty
                              ? Colors.green
                              : (_validatePassword(_passwordController.text) ==
                                      null
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: _passwordController.text.isEmpty
                              ? Colors.green
                              : (_validatePassword(_passwordController.text) ==
                                      null
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
                        Icons.lock,
                        color: Colors.white,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: _validatePassword,
                    onChanged: (_) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: _confirmPasswordController.text.isEmpty
                              ? Colors.green
                              : (_validatePassword(
                                          _confirmPasswordController.text) ==
                                      null
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: _confirmPasswordController.text.isEmpty
                              ? Colors.green
                              : (_validatePassword(
                                          _confirmPasswordController.text) ==
                                      null
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
                        Icons.lock,
                        color: Colors.white,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: _validateConfirmPassword,
                    onChanged: (_) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          _performRegistration(context);
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
                        'Register',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
