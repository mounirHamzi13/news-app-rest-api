import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:news_app/providers/themes.dart';
import 'package:provider/provider.dart';

import '../providers/article.dart';
import '../widgets/blurred_icon.dart';
import '../widgets/custom_tag.dart';

class ArticleScreen extends StatefulWidget {
  static String routeName = "/article_screen";
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<ArticleList>(context);
    String id = ModalRoute.of(context)!.settings.arguments as String;
    Article article = articleProvider.getItems.firstWhere(
      (element) => element.id == id,
    );


    // print(article.saved);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   iconTheme: const IconThemeData(color: Colors.white),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(article.imageUrl))),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              // color: Colors.white,
              gradient: const LinearGradient(
                  end: FractionalOffset.bottomRight,
                  begin: FractionalOffset.topLeft,
                  colors: [Colors.black87, Colors.black12],
                  stops: [0.0, 1.0])),
        ),
        ListView(children: [
          // height: MediaQuery.of(context).size.height * 0.35,
          Container(
            height: MediaQuery.of(context).size.height * 0.42,
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTag(
                    background: Colors.blue,
                    children: [
                      Text(
                        article.category,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.white),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      article.title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              fontWeight: FontWeight.bold,
                              height: 1.25,
                              color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                        
                        article.subtitle,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            
                            fontSize: 15,
                            color: Colors.grey.shade400,
                            height: 1.4
                            // color:
                            )),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: BoxDecoration(
                color: themeProvider.isDarkMode
                    ? const Color.fromARGB(255, 1, 23, 41)
                    : Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomTag(
                            background: Colors.black,
                            padding: 7,
                            radius: 30,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    article.authorImageUrl),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                article.author,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.white),
                              )
                            ]),
                        CustomTag(
                            // width: 80,
                            background: Colors.blue,
                            padding: 10,
                            radius: 30,
                            children: [
                              Icon(
                                Icons.date_range,
                                color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade900,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                article.createdAt.substring(6),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Colors.white, fontSize: 14),
                              )
                            ]),
                        // CustomTag(
                        //     width: 80,
                        //     background: Colors.blue,
                        //     padding: 10,
                        //     radius: 30,
                        //     children: [
                        //       Icon(Icons.remove_red_eye_outlined,
                        //           color: Colors.grey.shade700),
                        //       const SizedBox(
                        //         width: 10,
                        //       ),
                        //       Text(
                        //         article.views.toString(),
                        //         style: Theme.of(context)
                        //             .textTheme
                        //             .bodySmall!
                        //             .copyWith(
                        //                 color: Colors.white, fontSize: 14),
                        //       )
                        //     ])
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Text(
                        article.body,
                          // "fhsdjkfhjkdhsfjkhf",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 15,
                                    letterSpacing: 1.2,
                                    height: 1.3,
                                  )),
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
        Positioned(
            top: MediaQuery.of(context).size.height * 0.06,
            left: MediaQuery.of(context).size.height * 0.03,
            child: BlurredIcon(
              widget: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            )),
        Positioned(
            top: MediaQuery.of(context).size.height * 0.06,
            right: MediaQuery.of(context).size.height * 0.03,
            child: BlurredIcon(
              widget: IconButton(
                icon: Icon(
                  article.chooseSavedIcon(),
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    articleProvider.reverseSaved(article);
                    // article.reverseSaved();
                  });
                },
              ),
            )),
      ]),
    );
  }
}
