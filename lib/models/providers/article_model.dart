import 'dart:convert';
import 'package:cdr_app/models/json/article/article.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class ArticleModel with ChangeNotifier {
  final List<Article> _jsonDataList = [];

  List<Article> get jsonDataList => _jsonDataList;

  ArticleModel();

  Future<void> fetchData([String url = 'https://cdr.cz/']) async {
    final response = await http.get(Uri.parse(url));
    final utf8DecodedBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      final document = parse(utf8DecodedBody);
      final scriptTags = document.getElementsByTagName('script');

      for (var tag in scriptTags) {
        final typeAttribute = tag.attributes['type'];
        if (typeAttribute == 'application/ld+json') {
          final jsonText = tag.text.trim();
          final cleanedJsonText = jsonText.replaceAll('\n', '');
          final article = Article.fromJson(jsonDecode(cleanedJsonText));
          _jsonDataList.add(article);
        }
      }
      notifyListeners();
    }
  }
}



