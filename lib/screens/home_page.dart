// import 'dart:convert';
// import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:news_app/providers/article.dart';
// import 'package:news_app/screens/weather_screen.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
// import '../widgets/blurred_icon.dart';
// import '../widgets/bottom_nav_bar.dart';
// import '../widgets/article_list_widget.dart';
import '../widgets/breaking_news_widget.dart';
// import '../widgets/custom_tag.dart';
import '../widgets/home_page_picture.dart';
import '../widgets/saved_item_widget.dart';
import 'article_screen.dart';
// import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = '/home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isInit = true;
  bool isLoading = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isInit) {
      isLoading = true;
      await Provider.of<ArticleList>(context).fetchArticles();
      isInit = false;
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var articles = Provider.of<ArticleList>(context).getItems;
    // print('article length ${articles.length}');
    return Scaffold(
      drawer: const AppDrawer(),
      extendBodyBehindAppBar: true,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(padding: EdgeInsets.zero, children: [
              HomePagePicture(articles: articles),
              BreakingNews(articles: articles),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: articles.map((article) {
                    return InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, ArticleScreen.routeName,
                            arguments: article.id),
                        child: Container(  
                          margin: const EdgeInsets.only(bottom: 20),
                          child: SavedItemWidget(article: article)));
                  }).toList(),
                ),
              ),
              // BreakingNews
            ]),
    );
  }
}
