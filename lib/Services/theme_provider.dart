import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkModeEnabled = false;

  bool get isDarkModeEnabled => _isDarkModeEnabled;

  ThemeData get currentTheme => _isDarkModeEnabled ? darkTheme : lightTheme;

  void setDarkMode(bool value) {
    _isDarkModeEnabled = value;
    notifyListeners();
  }

  ThemeData get darkTheme => ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: const Color.fromARGB(255, 34, 87, 122),
        appBarTheme: AppBarTheme(
          color: Colors.black,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          toolbarTextStyle: const TextTheme(
            titleLarge: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
            ),
          ).bodyMedium,
          titleTextStyle: const TextTheme(
            titleLarge: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
            ),
          ).titleLarge,
        ),
        textTheme: const TextTheme(
          titleSmall: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          titleLarge: TextStyle(
              color: Colors.deepOrangeAccent,
              fontWeight: FontWeight.bold,
              fontSize: 25),
          titleMedium: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
          displayLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
          displayMedium: TextStyle(
            color: Color.fromARGB(255, 34, 87, 122),
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blue),
        // Add more properties as per your app's design requirements
      );

  ThemeData get lightTheme => ThemeData.light().copyWith(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: const Color.fromARGB(255, 199, 249, 204),
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          actionsIconTheme: IconThemeData(color: Colors.black),
          toolbarTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: const TextTheme(
          titleSmall: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          titleLarge: TextStyle(
              color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 25),
          titleMedium: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          bodyMedium: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 25,
          ),
          displayLarge: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
          displayMedium: TextStyle(
            color: Color.fromARGB(255, 199, 249, 204),
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
        ),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.blueAccent),
        // Add more properties as per your app's design requirements
      );
}
