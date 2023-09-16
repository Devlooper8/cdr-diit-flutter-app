import 'package:cdr_app/widgets/article_detail.dart';
import 'package:flutter/material.dart';

class ArticlePage extends StatelessWidget {
  final String imageUrl;
  final String headline;
  final String intro;
  final String articleUrl;

  const ArticlePage({
    Key? key,
    required this.imageUrl,
    required this.headline,
    required this.intro,
    required this.articleUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(headline),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity, // This makes the width take up the whole width of the screen
            padding: const EdgeInsets.only(bottom: 16.0,top: 8.0,left: 8.0,right: 8.0), // Add padding as needed
            alignment: Alignment.center, // Center the text horizontally and vertically
            child: Text(
              headline,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
      Container(
        width: double.infinity, // This makes the width take up the whole width of the screen
        padding: const EdgeInsets.only(left: 8.0,right: 8.0), // Add padding as needed
        alignment: Alignment.center, // Center the text horizontally and vertically
        child: Text(
              intro,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w900,
              ),
            ),
      ),
          ArticleDetail(
            url: articleUrl,
          ),
        ],
      ),
    );
  }
}
