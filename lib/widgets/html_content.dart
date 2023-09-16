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
      dom.Element? firstItemEvenElement = fieldNameBody.querySelector(
          'div.field-item.even'); // Replace with your actual CSS selector to select the first element

      List<Widget> widgets = [];

      if (firstItemEvenElement != null) {
        List<dom.Element> children = firstItemEvenElement.children;

        for (dom.Element child in children) {
          if (child.className.toLowerCase().contains('images')) {
            List<String> imageUrls = [];
            for (dom.Element imageChild in child.children) {
              if (imageChild.localName != null &&
                  !imageChild.localName!.contains('iframe')) {
                String? currentSrc = imageChild.attributes['href'];
                if (currentSrc != null) {
                  imageUrls.add(currentSrc);
                }
              }
            }
            widgets.add(
              Row(
                children: imageUrls.map((imageUrl) {
                  return Expanded(
                    child: CachedNetworkImage(
                      fit: BoxFit.cover, // This will make the image cover the whole width
                      imageUrl: imageUrl,
                      placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    ),
                  );
                }).toList(),
              ),
            );
          } else {}
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
