import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/article.dart';
import '../providers/themes.dart';
// import '../screens/saved_screen.dart';
import 'blurred_icon.dart';
import 'custom_tag.dart';


class SavedItemWidget extends StatefulWidget {
  final Article article;
  const SavedItemWidget({super.key, required this.article});

  @override
  State<SavedItemWidget> createState() => _SavedItemWidgetState();
}

class _SavedItemWidgetState extends State<SavedItemWidget> {
  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<ArticleList>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      // padding: EdgeInsets.only(bottom: 20),
      // width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.all(10),
      // height: MediaQuery.of(context).size.height * 0.4,
      // child: Card(
      
        color: themeProvider.isDarkMode
            ? const Color.fromRGBO(1, 138, 251, 0.4)
            : Colors.white,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  // borderRadius: const BorderRadius.only(
                  //     topLeft: Radius.circular(30),
                  //     topRight: Radius.circular(30)),
                  child: Image.network(
                      height: 320,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      widget.article.imageUrl),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      // borderRadius: BorderRadius.only(
                      //     topLeft: Radius.circular(30),
                      //     topRight: Radius.circular(30)),
                      gradient: LinearGradient(
                        colors: [Colors.black54, Colors.black12],
                        stops: [0, 1],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 10,
                    left: 10,
                    child: CustomTag(
                        background: Colors.blue.withAlpha(180),
                        padding: 10,
                        width: 100,
                        children: [
                          Text(
                            widget.article.category,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.white, fontSize: 18),
                          )
                        ])),
                Positioned(
                    top: 10,
                    right: 10,
                    child: BlurredIcon(
                        height: 50,
                        width: 50,
                        widget: IconButton(
                          icon: Icon(
                            widget.article.chooseSavedIcon(),
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              articleProvider.reverseSaved(widget.article);
                              // widget.article.reverseSaved();
                            });
                          },
                        )))
              ],
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 12),
              // color: themeProvider.isDarkMode ? Color.fromRGBO(1, 23, 41, 0.4)  : Colors.white,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    horizontalTitleGap: 0,
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(widget.article.authorImageUrl),
                      radius: 15,
                    ),
                    title: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Text(widget.article.author,
                          style: Theme.of(context).textTheme.bodyMedium!
                          // .copyWith(color: Colors.grey),
                          ),
                    ),
                    trailing: Text(
                        widget.article.createdAt,
                        style: Theme.of(context).textTheme.bodyLarge!
                        // .copyWith(color: Colors.grey),
                        ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      widget.article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                fontSize: 22,
                                letterSpacing: 1.2,
                              ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      // ),
    );
  }
}
