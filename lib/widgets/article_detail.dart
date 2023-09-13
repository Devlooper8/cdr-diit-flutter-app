import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:html/dom_parsing.dart';
class ArticleDetail extends StatelessWidget{
  final String headline;
  final String description;
  final CachedNetworkImage mainImage;
  final Element document;
  List<Widget> widgets =[];

  ArticleDetail(this.headline, this.description, this.mainImage, {super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    for(var i in document.children)
  }
  }
}