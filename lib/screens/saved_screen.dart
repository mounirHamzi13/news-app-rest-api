import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:news_app/providers/article.dart';
import 'package:news_app/providers/themes.dart';
import 'package:news_app/screens/article_screen.dart';
// import 'package:news_app/widgets/blurred_icon.dart';
// import 'package:news_app/widgets/custom_tag.dart';
import 'package:provider/provider.dart';

import '../widgets/saved_item_widget.dart';

class SavedScreen extends StatelessWidget {
  static String routeName = "/saved_screen";
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var articles = Provider.of<ArticleList>(context).getItems;
    // print(articles);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        body: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 50),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  // width: MediaQuery.of(context).size.width ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Mes Articles",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontSize: 45),
                      ),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: Icon(
                      //     size: 40,
                      //     Icons.more_horiz,
                      //     color: themeProvider.isDarkMode
                      //         ? Colors.grey.shade100
                      //         : Colors.grey,
                      //   ),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(child: SavedItemsWidget(articles: articles)),
      ],
    ));
  }
}

class SavedItemsWidget extends StatelessWidget {
  const SavedItemsWidget({
    super.key,
    required this.articles,
  });

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    List<Article> savedArticles =
        articles.where((element) => element.saved).toList();
    return savedArticles.isEmpty
        ? const Center(child: Text("No Saved Items "))
        : ListView(
            children: savedArticles.map((article) {
              return InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, ArticleScreen.routeName,
                      arguments: article.id),
                  child: SavedItemWidget(article: article));
            }).toList(),
          );
  }
}



