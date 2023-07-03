import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter_app/Screens/about_screen.dart';
import 'package:my_flutter_app/Screens/profile_screen.dart';

import 'package:my_flutter_app/Screens/registration_screen.dart';
import 'package:my_flutter_app/Screens/settings_screen.dart';
import 'package:provider/provider.dart';

import 'Screens/home_screen.dart';
import 'Screens/login_screen.dart';
import 'Screens/splash_screen.dart';
import 'Services/provider_service.dart';
import 'Services/theme_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //Setting Device orientation
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider()..loadThemePreference(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Ev Charging App',
            theme: themeProvider.currentTheme,
            initialRoute: '/',
            // Routes For Navigation
            routes: {
              '/': (ctx) => const SplashScreen(),
              LoginScreen.routeName: (ctx) => const LoginScreen(),
              HomeScreen.routeName: (ctx) => const HomeScreen(),
              RegistrationScreen.routeName: (ctx) => const RegistrationScreen(),
              SettingsPage.routeName: (ctx) => const SettingsPage(),
              AboutPageScreen.routeName: (ctx) => const AboutPageScreen(),
              ProfilePageScreen.routeName: (ctx) => ProfilePageScreen(
                    email: Provider.of<UserProvider>(context).loggedInEmail,
                  ),
            },
          );
        },
      ),
    );
  }
}
