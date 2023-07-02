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
        scaffoldBackgroundColor: Colors.black,
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
          titleLarge: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(color: Colors.white),
          displayMedium: TextStyle(color: Color.fromARGB(255, 34, 87, 122)),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blue),
        // Add more properties as per your app's design requirements
      );

  ThemeData get lightTheme => ThemeData.light().copyWith(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
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
          titleLarge: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: TextStyle(color: Colors.black),
          displayMedium: TextStyle(color: Color.fromARGB(255, 199, 249, 204)),
        ),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.blueAccent),
        // Add more properties as per your app's design requirements
      );
}
