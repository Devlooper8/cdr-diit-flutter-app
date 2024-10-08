import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // Added
import 'package:http/http.dart' as http;
import '../../models/article/article.dart';

class HomeScreenController extends GetxController {
  var jsonDataList = <Article>[].obs;
  var currentPage = 0.obs; // Observable to track the current page
  var isLoading = false.obs; // To track if data is being fetched
  var isSearching = false.obs;
  final TextEditingController searchController = TextEditingController();

  var bookmarkedArticles = <Article>[].obs; // Store full Article objects
  final storage = GetStorage(); // For persistent storage

  @override
  void onInit() {
    super.onInit();
    // Load bookmarked articles from storage
    List<dynamic>? storedBookmarks = storage.read('bookmarkedArticles');
    if (storedBookmarks != null) {
      // Deserialize each stored bookmark to an Article
      bookmarkedArticles.value = storedBookmarks.map((e) => Article.fromJson(e)).toList();
    }
    fetchData(); // Fetch initial data
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
  }

  void clearSearch() {
    searchController.clear();
    // Add any logic to handle the clear action, like reloading original data
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  // Method to toggle bookmark
  void toggleBookmark(Article article) {
    final existingArticle = bookmarkedArticles.firstWhereOrNull((a) => a.articleSlug == article.articleSlug);
    if (existingArticle != null) {
      bookmarkedArticles.remove(existingArticle);
    } else {
      bookmarkedArticles.add(article);
    }

    // Sort the list by the modified date in descending order, parsing strings to DateTime
    bookmarkedArticles.sort((a, b) => DateTime.parse(b.modified).compareTo(DateTime.parse(a.modified)));

    // Save updated bookmarks to storage (serialize each Article to JSON)
    storage.write('bookmarkedArticles', bookmarkedArticles.map((e) => e.toJson()).toList());

    // Update the article's isBookmarked property
    var articleIndex = jsonDataList.indexWhere((a) => a.articleSlug == article.articleSlug);
    if (articleIndex != -1) {
      jsonDataList[articleIndex].isBookmarked.value = bookmarkedArticles.any((a) => a.articleSlug == article.articleSlug);
      jsonDataList.refresh(); // Refresh the list to update UI
    }
  }



  // Fetch data for a given page and append to the list
  Future<void> fetchData([int page = 0]) async {
    if (isLoading.value) return; // Prevent multiple fetch requests at once
    isLoading.value = true; // Mark as loading

    try {
      final url = 'https://tomino.v2.sk/$page';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final articleResponse = ArticleResponse.fromJson(jsonResponse);

        // Update isBookmarked based on bookmarkedArticles
        for (var article in articleResponse.articles) {
          article.isBookmarked.value = bookmarkedArticles.any((a) => a.articleSlug == article.articleSlug);
        }

        // Append the new articles to the list
        jsonDataList.addAll(articleResponse.articles);
        currentPage.value = page; // Update current page
      } else {
        if (kDebugMode) {
          print("Failed to fetch data: ${response.statusCode}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error occurred while fetching data: $e");
      }
    } finally {
      isLoading.value = false; // Mark loading as finished
    }
  }

  // Fetch the next page
  void loadMoreData() {
    fetchData(currentPage.value + 1); // Fetch the next page
  }
}
