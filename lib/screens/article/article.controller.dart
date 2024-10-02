// article.controller.dart

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../models/article/article.dart';
import '../../models/article_detail/article_detail.dart';
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
  final isBookmarked = false.obs; // Observable to track bookmark status
  final BookmarkController bookmarkController = Get.find();

  @override
  void onInit() {
    super.onInit();

    // Retrieve slug from Get.parameters and initialize the bookmark status
    final slug = Get.parameters['slug'] ?? '';
    isBookmarked.value = bookmarkController.isBookmarked(slug);
  }

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

  void toggleBookmark() {
    final article = articleDetail.value.toArticle();
    bookmarkController.toggleBookmark(article);
    isBookmarked.value = !isBookmarked.value; // Update the local bookmark state
  }
}

extension ArticleDetailExtension on ArticleDetail {
  Article toArticle() {
    return Article(
      articleSlug: slug,
      title: title,
      description: '', // Add if necessary
      image: image,
      url: '', // If you have a url field
      published: '', // If needed
      modified: modified,
      author: author.name, // Assuming the `Author` model has a `name` field
    );
  }
}