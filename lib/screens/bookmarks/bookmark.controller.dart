import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/article/article.dart'; // Import the Article model

class BookmarkController extends GetxController {
  var bookmarkedArticles = <Article>[].obs; // List of bookmarked articles
  final storage = GetStorage(); // For persistent storage

  @override
  void onInit() {
    super.onInit();
    // Load bookmarked articles from local storage (if necessary, serialization/deserialization can be added here)
    List<dynamic>? storedBookmarks = storage.read('bookmarkedArticles');
    if (storedBookmarks != null) {
      bookmarkedArticles.value = storedBookmarks.map((e) => Article.fromJson(e)).toList();
    }
  }

  void toggleBookmark(Article article) {
    // Check if article is already bookmarked
    final existingArticle = bookmarkedArticles.firstWhereOrNull((a) => a.articleSlug == article.articleSlug);
    if (existingArticle != null) {
      // Remove if already bookmarked
      bookmarkedArticles.remove(existingArticle);
    } else {
      // Add if not bookmarked
      bookmarkedArticles.add(article);
    }

    // Sort the list by the modified date in descending order, parsing strings to DateTime
    bookmarkedArticles.sort((a, b) => DateTime.parse(b.modified).compareTo(DateTime.parse(a.modified)));

    // Save the updated list of bookmarks to local storage (serialize the articles)
    storage.write('bookmarkedArticles', bookmarkedArticles.map((e) => e.toJson()).toList());
  }



  bool isBookmarked(String slug) {
    return bookmarkedArticles.any((article) => article.articleSlug == slug);
  }
}
