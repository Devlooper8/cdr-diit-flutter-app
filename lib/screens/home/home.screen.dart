// home.screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../widgets/drawer/drawer.dart';
import '../bookmarks/bookmark.controller.dart';
import 'home.controller.dart'; // Import BookmarkController

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookmarkController bookmarkController = Get.put(BookmarkController());

    ScrollController scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200 &&
          !controller.isLoading.value) {
        controller.loadMoreData(); // Fetch more data
      }
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
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
          )
              : Text(
            "Články",
            style: Theme.of(context).textTheme.headlineLarge,
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
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).colorScheme.surface
            ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: Obx(() {
          if (controller.jsonDataList.isEmpty && controller.isLoading.value) {
            return const Center(
                child: CircularProgressIndicator());
          }
          return ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: controller.jsonDataList.length + 1,
            cacheExtent: controller.jsonDataList.length + 1,
            itemBuilder: (context, index) {
              if (index == controller.jsonDataList.length) {
                return Obx(() {
                  if (controller.isLoading.value) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                });
              }

              final article = controller.jsonDataList[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      '/article',
                      parameters: {
                        'slug': article.articleSlug.toString(),
                        'modified': article.modified.toString(),
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
                              maxHeightDiskCache: 90,
                              memCacheHeight: 90,
                              maxWidthDiskCache: 90,
                              memCacheWidth: 90,
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
                                Obx(() {
                                  return IconButton(
                                    icon: Icon(
                                      bookmarkController.isBookmarked(article.articleSlug)
                                          ? Icons.bookmark
                                          : Icons.bookmark_border,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    onPressed: () {
                                      // Pass the entire article object to the controller
                                      bookmarkController.toggleBookmark(article);
                                    },
                                  );
                                }),
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
