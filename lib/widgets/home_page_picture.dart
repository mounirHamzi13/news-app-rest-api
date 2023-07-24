import 'package:flutter/material.dart';
import 'package:news_app/screens/article_screen.dart';

import '../providers/article.dart';
import 'blurred_icon.dart';
import 'custom_tag.dart';

class HomePagePicture extends StatelessWidget {
  const HomePagePicture({
    super.key,
    required this.articles,
  });

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    // print(articles);
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.transparent,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                articles[0].imageUrl,
              ),
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.45,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
              gradient: const LinearGradient(
                  end: FractionalOffset.bottomRight,
                  begin: FractionalOffset.topLeft,
                  colors: [Colors.black87, Colors.black12],
                  stops: [0.0, 1.0])),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTag(
                  background: Colors.blue,
                  children: [
                    Text(
                      "Actualités du jour",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    articles[0].title,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1.25,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    // Scaffold.of(context).openDrawer();
                    Navigator.of(context).pushNamed(ArticleScreen.routeName,
                        arguments: articles[0].id);
                  },
                  child: Row(
                    children: [
                      Text(
                        "En savoir plus",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.arrow_forward_sharp,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
            // height: MediaQuery.of(context).size.height,
            top: MediaQuery.of(context).size.height * 0.06,
            left: MediaQuery.of(context).size.height * 0.03,
            child: InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: BlurredIcon(
                  widget: IconButton(
                color: Colors.white,
                icon: const Icon(size: 30, Icons.menu),
                onPressed: () {
                  print("hello");
                  Scaffold.of(context).openDrawer();
                },
              )),
            ))
      ],
    );
  }
}
