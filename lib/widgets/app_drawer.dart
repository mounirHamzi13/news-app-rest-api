import 'package:flutter/material.dart';
import 'package:news_app/providers/auth.dart';
import 'package:news_app/providers/themes.dart';
import 'package:provider/provider.dart';

import '../screens/weather_screen.dart';
import 'custom_tag.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Auth>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Drawer(
        backgroundColor: themeProvider.isDarkMode
            ? const Color.fromRGBO(1, 23, 41, 1)
            : Colors.white,
        width: MediaQuery.of(context).size.width * 0.85,
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/pictures/MplusTV.jpg',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Positioned(
                  // right: 10,
                  left: 10,
                  bottom: 10,
                  child: CustomTag(
                    background: Colors.blue,
                    padding: 10,
                    // width: 150,
                    children:  [
                      const Icon(Icons.account_circle),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        // 'fjsdklfjsd' ,
                        Auth.email ,
                        // authProvider,
                        style: TextStyle(letterSpacing: 1.2),
                      )
                    ],
                    // child: ListTile(
                    //   leading: CircleAvatar(
                    //     child: Icon(Icons.account_circle),
                    //   ),
                    //   title: Text('Email Title',  ), // Added email title
                    // ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 15, right: 10),
              child: Column(children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(WeatherScreen.routeName);
                    Scaffold.of(context).closeDrawer();
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: themeProvider.isDarkMode
                        ? const Color.fromRGBO(1, 138, 251, 0.671)
                        : Colors.white,
                    elevation: 12,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.cloud,
                          color: themeProvider.isDarkMode
                              ? Colors.white
                              : Colors.grey,
                          size: 30,
                        ),
                        title: Text('Météo',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 20)
                            /*  TextStyle(color: Colors.grey, fontSize: 20), */
                            ),
                      ),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: themeProvider.isDarkMode
                      ? const Color.fromRGBO(1, 138, 251, 0.671)
                      : Colors.white,
                  elevation: 12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      trailing: const ChangeThemeButtonWidget(),
                      leading: Icon(
                        Icons.dark_mode,
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.grey,
                        size: 30,
                      ),
                      title: Text('Mode Somrbe',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 20)),
                    ),
                  ),
                )
              ]),
            )
          ],
        ));
  }
}

class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return Switch.adaptive(
          value: themeProvider.isDarkMode,
          onChanged: (value) {
            themeProvider.toggleTheme(value);
          },
        );
      },
    );
  }
}
