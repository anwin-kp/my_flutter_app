import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter_app/Screens/registration_screen.dart';

import 'Screens/home_screen.dart';
import 'Screens/login_screen.dart';
import 'Screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Setting Device orientation
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ev Charging App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        // Routes For Navigation
        routes: {
          '/': (ctx) => const SplashScreen(),
          LoginScreen.routeName: (ctx) => const LoginScreen(),
          HomeScreen.routeName: (ctx) => const HomeScreen(),
          RegistrationScreen.routeName: (ctx) => const RegistrationScreen(),
        });
  }
}
