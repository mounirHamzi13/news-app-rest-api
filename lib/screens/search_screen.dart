import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:news_app/providers/article.dart';
import 'package:news_app/providers/themes.dart';
// import 'package:news_app/screens/article_screen.dart';
import 'package:news_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

// import '../widgets/bottom_nav_bar.dart';
import '../widgets/article_list_widget.dart';
import '../widgets/category_tabs_widget.dart';
import '../widgets/discover_widget.dart';

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
  // List<String> tabs = ['Health', 'Politics', 'Art', 'Food', 'Science'];
  const SearchScreen({super.key});
  static String routeName = '/search_screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Article> searchedArticles = [];
  @override
  Widget build(BuildContext context) {
    var articleListProvider = Provider.of<ArticleList>(context);

    void filterArticles(String text) {
      setState(() {
        // searchText = text;
        // print(searchText);
        if (text.isEmpty) {
          searchedArticles = [];
        } else {
          searchedArticles = articleListProvider.getItems
              .where((element) =>
                  element.title.toLowerCase().contains(text.toLowerCase()))
              .toList();
        }
      });
    }

    List<Article> articleList = articleListProvider.getItems;
    List<String> tabs = articleListProvider.categories;
    tabs = tabs.where((tab) => articleList.any((article) => article.category == tab)).toList();

    
    tabs = tabs.map((String tab) {
      // Capitalize the first letter of the string
      String capitalized = tab.substring(0, 1).toUpperCase() + tab.substring(1);
      return capitalized;
    }).toList();
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: const MenuIcon(),
          ),
          drawer: const AppDrawer(),
          body: ListView(
            padding: const EdgeInsets.only(left: 20, right: 20),
            children: [
              DiscoverWidget(
                filterFunction: filterArticles,
              ),
              searchedArticles.isEmpty /* && searchText =='' */
                  ? CategoryNewsWidget(
                      tabs: tabs,
                    )
                  : ArticleListWidget(array: searchedArticles)
            ],
          ),
        ));
  }
}

class MenuIcon extends StatelessWidget {
  const MenuIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return IconButton(
        onPressed: () {
          print(context);
          Scaffold.of(context).openDrawer();
        },
        icon: Icon(
          Icons.menu,
          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
        ));
  }
}

// ignore: must_be_immutable
