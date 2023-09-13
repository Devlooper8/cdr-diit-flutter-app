import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageListTile extends StatelessWidget {
  final String imageUrl;
  final String headline;
  final String intro;
  final bool isBookmarked;
  final VoidCallback? onBookmarkPressed;
  final VoidCallback? onTap; // Add the onTap function pointer

  const ImageListTile({
    Key? key,
    required this.imageUrl,
    required this.headline,
    required this.intro,
    this.isBookmarked = false,
    this.onBookmarkPressed,
    this.onTap, // Initialize the onTap function pointer
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: InkWell(
                onTap: onTap, // Call the onTap function when InkWell is tapped
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: AspectRatio(
                        aspectRatio: 15 / 9,
                        child: CachedNetworkImage(
                          fadeInDuration: const Duration(milliseconds: 200),
                          imageUrl: imageUrl,
                          fit: BoxFit.fill,
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          headline,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              ),
              onPressed: onBookmarkPressed,
            ),
          ],
        ),
      ),
    );
  }
}