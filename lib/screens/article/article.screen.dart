// article.screen.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'article.controller.dart';
import '../bookmarks/bookmark.controller.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArticleScreen extends GetView<ArticleScreenController> {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve slug and modified from Get.parameters
    final slug = Get.parameters['slug'] ?? '';
    final modified = Get.parameters['modified'] ?? '';

    // Fetch the article when the screen is built
    controller.fetchArticle(slug, modified);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Theme.of(context).appBarTheme.iconTheme?.color),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          Obx(() {
            return IconButton(
              icon: Icon(
                controller.isArticleBookmarked()
                    ? Icons.bookmark
                    : Icons.bookmark_border,
                color: Theme.of(context).appBarTheme.iconTheme?.color,
              ),
              onPressed: () {
                controller.toggleBookmark();
              },
            );
          }),
        ],
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
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final article = controller.articleDetail.value;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card layout for the title and image
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 4,
                    color: Theme.of(context).cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.title,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const SizedBox(height: 16),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: CachedNetworkImage(
                              imageUrl: article.image,
                              placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Author information
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Author: ${article.author.name}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Card layout for the article content
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 4,
                    color: Theme.of(context).cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: HtmlWidget(
                        article.content,
                        textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Button to open the original article (if needed)
                  Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      icon: const Icon(Icons.open_in_browser, color: Colors.white),
                      label: const Text(
                        'Open Original Article',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () {
                        // Handle button tap to open the original article URL
                        // You can use url_launcher package to open the link
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
