import 'package:cdr_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'home.controller.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a ScrollController to detect when the user reaches the bottom
    ScrollController scrollController = ScrollController();

    // Listen for when the user is scrolling close to the bottom of the list
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200 && // Trigger when close to bottom (200px threshold)
          !controller.isLoading.value) {
        controller.loadMoreData(); // Fetch more data
      }
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // Use theme app bar color
        elevation: 0,
        title: Obx(() {
          return controller.isSearching.value
              ? TextField(
            controller: controller.searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Search articles...',
              border: InputBorder.none,
              hintStyle: Theme.of(context).textTheme.bodyLarge,
            ),
            style: Theme.of(context).textTheme.bodyLarge,
            onChanged: (value) {
              // Add logic here to filter the articles list as the user types
            },
          )
              : Text(
            "Články",
            style: Theme.of(context).textTheme.headlineLarge, // Use theme text style for the title
          );
        }),
        actions: [
          Obx(() {
            return controller.isSearching.value
                ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                controller.clearSearch();
                controller.toggleSearch();
              },
            )
                : IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                controller.toggleSearch();
              },
            );
          }),
        ],
      ),
      drawer: const CdrDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).scaffoldBackgroundColor, // Use theme background color
              Theme.of(context).colorScheme.surface // Use theme secondary background color
            ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: Obx(() {
          if (controller.jsonDataList.isEmpty && controller.isLoading.value) {
            return const Center(
                child: CircularProgressIndicator()); // Show loading initially
          }
          return ListView.builder(
            controller: scrollController, // Attach the ScrollController
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: controller.jsonDataList.length + 1, // +1 for the loading indicator at the end
            itemBuilder: (context, index) {
              if (index == controller.jsonDataList.length) {
                // Display a loading indicator at the end of the list when more data is loading
                return Obx(() {
                  if (controller.isLoading.value) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    return const SizedBox.shrink(); // Return nothing if no more data is being fetched
                  }
                });
              }

              final article = controller.jsonDataList[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to ArticleScreen with slug and modified date using named route
                    Get.toNamed(
                      '/article',
                      parameters: {
                        'slug': article.articleSlug,
                        'modified': article.modified,
                      },
                    );
                  },
                  child: Card(
                    color: Theme.of(context).cardColor, // Use theme card color
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  article.title,
                                  style: Theme.of(context).textTheme.bodyLarge, // Use theme text style for article title
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today_outlined,
                                      size: 14,
                                      color: Theme.of(context).iconTheme.color, // Use theme icon color
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        article.modified,
                                        style: Theme.of(context).textTheme.bodyMedium, // Use theme text style for article date
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
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
