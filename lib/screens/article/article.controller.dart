// article.controller.dart

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../models/article/article.dart';
import '../../models/article/article_detail.dart';
import '../bookmarks/bookmark.controller.dart'; // Import BookmarkController

class ArticleScreenController extends GetxController {
  var articleDetail = ArticleDetail(
    slug: '',
    title: '',
    content: '',
    image: '',
    author: Author(slug: '', name: ''),
    modified: '',
  ).obs;

  var isLoading = true.obs;
  final BookmarkController bookmarkController = Get.find();

  Future<void> fetchArticle(String slug, String modified) async {
    try {
      isLoading.value = true;
      final url = 'https://tomino.v2.sk/article/$slug?modified=$modified';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        articleDetail.value = ArticleDetail.fromJson(jsonResponse);
      } else {
        if (kDebugMode) {
          print("Failed to fetch article: ${response.statusCode}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error occurred while fetching article: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }

  bool isArticleBookmarked() {
    return bookmarkController.isBookmarked(articleDetail.value.slug);
  }

  void toggleBookmark() {
    // Convert the ArticleDetail to Article for bookmarking
    final article = articleDetail.value.toArticle();
    bookmarkController.toggleBookmark(article);
  }
}
extension ArticleDetailExtension on ArticleDetail {
  Article toArticle() {
    return Article(
      articleSlug: slug,
      title: title,
      description: '', // If you want, you can add this field
      image: image,
      url: '', // If you have a url field
      published: '', // If needed
      modified: modified,
      author: author.name, // Assuming the `Author` model has a `name` field
    );
  }
}
