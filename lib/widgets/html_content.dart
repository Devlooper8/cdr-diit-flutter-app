import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:cached_network_image/cached_network_image.dart';

class HtmlContentWidget extends StatelessWidget {
  final dom.Document document;

  const HtmlContentWidget({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    dom.Element? fieldNameBody = document.querySelector(
        '.field-name-body'); // Replace with your actual CSS selector

    if (fieldNameBody != null) {
      List<dom.Element> itemEvenElements = fieldNameBody.querySelectorAll(
          '.item-even'); // Replace with your actual CSS selector

      List<Widget> widgets = [];

      for (dom.Element itemEvenElement in itemEvenElements) {
        List<dom.Element> children = itemEvenElement.children;
        if (itemEvenElement.localName!.toLowerCase().contains('img')) {
          // Check if there are multiple children and if any child contains "currentsrc" attribute
          if (children
              .any((element) => element.attributes.containsKey('src'))) {
            List<String> imageUrls = [];

            for (dom.Element childElement in children) {
              // Check if the current child has a "src" attribute
              String? currentSrc = childElement.attributes['src'];
              if (currentSrc != null) {
                imageUrls.add(currentSrc);
              }
            }

            // Create a row of cached images using the image URLs
            widgets.add(
              Row(
                children: imageUrls.map((imageUrl) {
                  return CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  );
                }).toList(),
              ),
            );
          }
        }
      }

      return Column(
        children: widgets,
      );
    } else {
      return const Center(
          child: Text('No .field-name-body found in HTML document.'));
    }
  }
}
