import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/article.dart';
import '../providers/themes.dart';
import '../screens/article_screen.dart';

class ArticleListWidget extends StatelessWidget {
  const ArticleListWidget({
    super.key,
    required this.array,
  });

  final List<Article> array;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: array.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ArticleScreen.routeName,
                  arguments: array[index].id);
            },
            child: Row(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.26,
                    height: MediaQuery.of(context).size.width * 0.26 - 10,
                    // height: MediaQuery.of(context).size.height*0.4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        array[index].imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.width * 0.2,
                  alignment: Alignment.topLeft,
                  // clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          array[index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  height: 1.2,
                                  letterSpacing: 1.2),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  color: themeProvider.isDarkMode
                                      ? Colors.grey.shade100
                                      : Colors.grey,
                                  size: 18,
                                  Icons.watch_later_outlined,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    array[index].createdAt,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge!
                                    // .copyWith(color: Colors.grey),
                                    )
                              ],
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Row(
                              children: [
                                Icon(
                                  color: themeProvider.isDarkMode
                                      ? Colors.grey.shade100
                                      : Colors.grey,
                                  size: 18,
                                  Icons.remove_red_eye,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text("${array[index].views} views",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge!
                                    // .copyWith(color: Colors.grey),
                                    )
                              ],
                            )
                          ],
                        ),
                      ]),
                ),
              ],
            ),
          );
        });
  }
}
