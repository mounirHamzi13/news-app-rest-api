import 'dart:convert';
// import 'dart:io';
// import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/providers/auth.dart';
import 'package:intl/intl.dart';

var userId = Auth.userId;

class Article with ChangeNotifier {
  var requestBody;

  String id;
  String title;
  String subtitle;
  String body;
  String author;
  String authorImageUrl;
  String category;
  final String imageUrl;
  int views;
  String createdAt;
  bool saved;
  Article(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.body,
      required this.author,
      required this.authorImageUrl,
      required this.category,
      required this.imageUrl,
      this.views = 0,
      required this.createdAt,
      required this.saved});

  // void reverseSaved() async {
  //   saved = !saved;
  //   try {
  //     var response = await http.post(
  //       Uri.parse('http://192.168.0.189/pfe/user/savingmecanism.php'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode(requestBody),
  //     );
  //     print(response.body);
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  IconData chooseSavedIcon() {
    return saved ? Icons.bookmark_outlined : Icons.bookmark_border;
  }
}

class ArticleList with ChangeNotifier {
  Auth? authProvider;
  String baseUrl = "https://192.168.0.189/PFE/images/";

  List<String> categories = [];
  List<Article> articles = [];

  List<Article> get getItems {
    return [...articles];
  }

  var requestBody = {
    'userId': 1, // userId
  };
  void reverseSaved(Article article) async {
    print('reverse saving');
    article.saved = !article.saved;
    try {
      var response = await http.post(
        Uri.parse('http://192.168.0.189/pfe/user/savingmecanism.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id_article': article.id, 'id_user': 1}),
      );

      print(response.body);
    } catch (error) {
      rethrow;
    }
    // notifyListeners();
  }

  Future<List<Article>> fetchSavedArticles() async {
    try {
      var response = await http.post(
        Uri.parse('http://192.168.0.189/pfe/user/sendsavedarticles.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);

        if (responseBody['savedIDs'] != null) {
          List<int> savedIDs = List<int>.from(responseBody['savedIDs']);

          List<Article> savedArticles = articles
              .where((article) => savedIDs.contains(article.id))
              .toList();

          return savedArticles;
        }
      }
    } catch (e) {
      print('Error fetching saved articles: $e');
    }

    return []; // Return an empty array if there are no saved articles or an error occurred
  }

  Future<void> fetchArticles() async {
    bool checkIfSaved(String id, List savedIDs) {
      print(id);
      print(savedIDs);
      for (var idArticle in savedIDs) {
        if (id == idArticle['id_article']) {
          return true;
        }
      }
      return false;
    }

    try {
      var response = await http.post(
        Uri.parse('http://192.168.0.189/pfe/user/sendarticlecat.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        // print('this is the response body' + responseBody.toString());
        if (responseBody == null) {
          articles = [];
        } else {
          List<Article> loadedArticles = [];
          // print('this is the image /////////////' +
          //     baseUrl +
          //     responseBody['articles'][0]['author_image']);
          for (var articleMap in responseBody['articles']) {
            var article = Article(
              id: articleMap['id'],
              title: articleMap['title'],
              subtitle: articleMap['subtitle1'],
              body: '\t${articleMap['subtitle2']} \n\n   \t${articleMap['subtitle3']} \n\n \t${articleMap['subtitle4']} ',
              author: articleMap['author_name'],
              authorImageUrl: baseUrl + articleMap['author_image'],
              category: articleMap['category_name'],
              imageUrl: baseUrl + articleMap['imageP'],
              createdAt: DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(articleMap['date_creation'])),
              saved: checkIfSaved(articleMap['id'], responseBody['savedIDs']),
            );
            loadedArticles.add(article);
            article.requestBody = {'id_user': 1, 'id_article': article.id};
          }
          articles = loadedArticles;

          // Get categories
          List<String> loadedCategories = [];
          for (var categoryMap in responseBody['categories']) {
            loadedCategories.add(categoryMap['nom']);
          }
          categories = loadedCategories;
        }
        notifyListeners();
      } else {
        throw Exception('Failed to fetch articles: ${response.statusCode}');
      }
    } catch (error) {
      print(error);
      throw Exception('Failed to fetch articles: $error');
    }
  }
}
