import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../models/article/article_detail.dart';

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

  Future<void> fetchArticle(String slug, String modified) async {
    try {
      isLoading.value = true;
      final url = 'https://tomino.v2.sk/article/$slug?modified=$modified';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        articleDetail.value = ArticleDetail.fromJson(jsonResponse);
      } else {
        // Handle error
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
}
