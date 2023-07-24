import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}


class MyThemes {
  static final darkTheme = ThemeData(
    hintColor: Colors.grey.shade800,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.grey.shade200),
        headlineSmall: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold, letterSpacing: 1),
          headlineLarge: const TextStyle(color: Colors.white, letterSpacing: 1, fontWeight: FontWeight.bold),
          bodySmall: TextStyle(color: Colors.grey.shade100, letterSpacing: 2)),
      // drawerTheme: DrawerThemeData(backgroundColor: Color.fromARGB(255, 1, 23, 41) ,),
      // bottomNavigationBarTheme:const BottomNavigationBarThemeData(backgroundColor: Color.fromARGB(255, 1, 23, 41) ,),
      scaffoldBackgroundColor: const Color.fromARGB(255, 1, 23, 41),
      colorScheme: const ColorScheme.dark());

  static final lightTheme = ThemeData(
      textTheme: TextTheme(
                bodyLarge: const TextStyle(color: Colors.grey),
        headlineSmall: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold, letterSpacing: 1),
        headlineLarge: const TextStyle(color: Colors.black, letterSpacing: 1, fontWeight: FontWeight.bold),
        bodySmall: TextStyle(color: Colors.grey.shade900, letterSpacing: 1.2),
      ),
      scaffoldBackgroundColor: Colors.grey.shade50,
      colorScheme: const ColorScheme.light());
}
