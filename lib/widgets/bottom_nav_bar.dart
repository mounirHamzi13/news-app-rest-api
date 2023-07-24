import 'package:flutter/material.dart';
import 'package:news_app/providers/themes.dart';
import 'package:news_app/screens/home_page.dart';
import 'package:news_app/screens/search_screen.dart';
import 'package:provider/provider.dart';

import '../screens/saved_screen.dart';

class BottomNavBar extends StatefulWidget {
  static String routeName = '/bottomNavBar';
  const BottomNavBar({
    super.key,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int chosenWidget = 0;
  List<Widget> theWidget = [
    const HomePage(),
    const SearchScreen(),
    const SavedScreen(),
  ];
  void selectedWidget(index) {
    setState(() {
      
      // Scaffold.of(context).widget.body!.createElement(Card());
      chosenWidget = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context) ;
    return Scaffold(
      body: theWidget[chosenWidget],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: themeProvider.isDarkMode ? const Color.fromARGB(255, 1, 23, 41) : Colors.white ,
        selectedItemColor:themeProvider.isDarkMode ? Colors.white : Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: themeProvider.isDarkMode ? Colors.white.withAlpha(100) : Colors.black.withAlpha(100),
        currentIndex: chosenWidget,
        onTap: selectedWidget,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Saved"),
        ],
      ),
    );
  }
}
