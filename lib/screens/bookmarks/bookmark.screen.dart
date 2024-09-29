// bookmark.screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'bookmark.controller.dart';

class BookmarkScreen extends GetView<BookmarkController> {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        title: Text(
          "Bookmarked Articles",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).colorScheme.surface,
            ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        // Use Obx to observe changes in the bookmarked articles
        child: Obx(() {
          final bookmarkedArticles = controller.bookmarkedArticles;

          if (bookmarkedArticles.isEmpty) {
            return const Center(
              child: Text("No bookmarked articles found."),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: bookmarkedArticles.length,
            itemBuilder: (context, index) {
              final article = bookmarkedArticles[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      '/article',
                      parameters: {
                        'slug': article.articleSlug,
                        'modified': article.modified,
                      },
                    );
                  },
                  child: Card(
                    color: Theme.of(context).cardColor,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      height: 100,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl: article.image,
                              maxHeightDiskCache: 100,
                              memCacheHeight: 100,
                              maxWidthDiskCache: 100,
                              memCacheWidth: 100,
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        article.title,
                                        style: Theme.of(context).textTheme.bodyLarge,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today_outlined,
                                            size: 14,
                                            color: Theme.of(context).iconTheme.color,
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                            child: Text(
                                              article.modified,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Bookmark icon
                                IconButton(
                                  icon: Icon(
                                    controller.isBookmarked(article.articleSlug)
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                  onPressed: () {
                                    controller.toggleBookmark(article);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
