import 'package:cdr_app/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'article.controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArticleScreen extends GetView<ArticleScreenController> {
  const ArticleScreen({super.key});

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
        backgroundColor: Theme.of(context)
            .appBarTheme
            .backgroundColor, // Use the theme color
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Theme.of(context).appBarTheme.iconTheme?.color), // Use theme icon color
          onPressed: () {
            Get.back(); // Navigate back
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share,
                color:
                    Theme.of(context).appBarTheme.iconTheme?.color), // Use theme icon color
            onPressed: () {
              // Share the article using the Share package
              /*controller.articleDetail.value.url != null
                  ? Share.share(controller.articleDetail.value.url)
                  : null;*/
            },
          ),
          IconButton(
            icon: Icon(Icons.bookmark,
                color:
                    Theme.of(context).appBarTheme.iconTheme?.color), // Use theme icon color
            onPressed: () {
              if (kDebugMode) {
                print('Bookmarking article');
              }
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context)
                  .scaffoldBackgroundColor, // Use theme background color
              Theme.of(context)
                  .colorScheme
                  .surface // Use theme secondary background color
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
                    color: Theme.of(context).cardColor, // Use theme card color
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge, // Use theme text style
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
                        color: Theme.of(context)
                            .iconTheme
                            .color, // Use theme icon color
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Author: ${article.author.name}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium, // Use theme text style
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Card layout for the article content with modern design and rounded corners for images
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 4,
                    color: Theme.of(context).cardColor, // Use theme card color
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: HtmlWidget(
                        article.content,
                        customStylesBuilder: (element) {
                          if (element.localName == 'p') {
                            return {
                              'color': Theme.of(context).textTheme.bodyLarge!.color!.toHex(),
                              'margin': '16px 0',
                              'line-height': '1.6',
                              'text-align': 'left',
                              'font-size': '16px',
                            };
                          }

                          if (element.localName == 'h1' || element.localName == 'h2') {
                            return {
                              'font-weight': 'bold',
                              'margin': '24px 0',
                              'color': Theme.of(context).textTheme.headlineLarge!.color!.toHex(),
                            };
                          }

                          if (element.localName == 'a') {
                            return {
                              'color': Theme.of(context).colorScheme.secondary.toHex(),
                              'text-decoration': 'none',
                            };
                          }

                          return null;
                        },
                        customWidgetBuilder: (element) {
                          if (element.localName == 'img') {
                            final imageUrl = element.attributes['src'] ?? '';
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                placeholder: (context, url) => const CircularProgressIndicator(),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            );
                          }
                          return null;
                        },
                        textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  // Button to show link for the article (if needed)
                  Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context)
                            .primaryColor, // Use theme primary color
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      icon: const Icon(Icons.open_in_browser,
                          color: Colors.white),
                      label: const Text(
                        'Open Original Article',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () {
                        // Handle button tap to open the original article
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

  // A helper method to launch URLs
  void launchUrl(String url) {
    // Use url_launcher or any other method to open the URL in the browser
    if (kDebugMode) {
      print("Opening URL: $url");
    }
    // Example: launch(url); (You can add url_launcher package to handle this)
  }
}
