import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/providers/article.dart';
import 'package:news_app/providers/auth.dart';
import 'package:news_app/providers/themes.dart';
import 'package:news_app/screens/article_screen.dart';
import 'package:news_app/screens/home_page.dart';
import 'package:news_app/screens/saved_screen.dart';
import 'package:news_app/screens/search_screen.dart';
import 'package:news_app/screens/signup_screen.dart';
// import 'package:news_app/screens/login_screen.dart';
import 'package:news_app/screens/weather_screen.dart';
import 'package:news_app/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

import 'models/clientsecurity.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
      HttpOverrides.global = MyHttpOverrides();
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> Auth()),
        ChangeNotifierProvider(create: (context) => ArticleList()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: "News App",
            debugShowCheckedModeBanner: false,
            // initialRoute: BottomNavBar.routeName,
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            home:  const SignUpScreen(),
            routes: {
              SignUpScreen.routeName : (context)=> const SignUpScreen(),
              WeatherScreen.routeName: (context) =>  WeatherScreen(),
              BottomNavBar.routeName: (context) => const BottomNavBar(),
              HomePage.routeName: (context) => const HomePage(),
              SearchScreen.routeName: (context) => const SearchScreen(),
              SavedScreen.routeName: (context) => const SavedScreen(),
              ArticleScreen.routeName: (context) => const ArticleScreen(),
            },
          );
        },
      ),
    );
  }
}
