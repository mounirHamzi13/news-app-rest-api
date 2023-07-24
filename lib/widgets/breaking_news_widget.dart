import 'package:flutter/material.dart';
import 'package:news_app/providers/article.dart';
import 'package:news_app/providers/themes.dart';
import 'package:news_app/screens/article_screen.dart';
import 'package:provider/provider.dart';

class BreakingNews extends StatelessWidget {
  const BreakingNews({super.key, required this.articles});
  final List<Article> articles;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20 , horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Dernières nouvelles",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    // letterSpacing: 1
                    ),
              ),
              Text(
                'Plus',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(letterSpacing: 1, color: Colors.blue),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: 280,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: articles.length,
                itemBuilder: (context, index) =>
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(ArticleScreen.routeName , arguments: articles[index].id);
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Card(
                        elevation: 10,
                        color:themeProvider.isDarkMode ? const Color.fromRGBO(1, 138, 251, 0.4)  : Colors.white,
                        // elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        // padding: EdgeInsets.all(5),
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        // width: MediaQuery.of(context).size.width * 0.6,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              
                              borderRadius:const BorderRadius.only(topLeft:Radius.circular(20) , topRight: Radius.circular(20)),
                              child: Image.network(articles[index].imageUrl, height: 150, width: MediaQuery.of(context).size.width, fit: BoxFit.cover,),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8, top: 8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      articles[index].title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              height: 1.4,
                                              fontSize: 18),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              articles[index].createdAt,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              "By ${articles[index].author}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ),
          ),
        )
      ],
    );
  }
}
