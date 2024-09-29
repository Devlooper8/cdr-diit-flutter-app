import 'package:json_annotation/json_annotation.dart';
import 'package:get/get.dart'; // Import GetX package

part 'article.g.dart';

@JsonSerializable()
class ArticleResponse {
  final List<Article> articles;

  ArticleResponse({required this.articles});

  factory ArticleResponse.fromJson(Map<String, dynamic> json) =>
      _$ArticleResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleResponseToJson(this);
}

@JsonSerializable()
class Article {
  @JsonKey(name: 'article_slug')
  final String articleSlug;
  final String title;
  final String description;
  final String image;
  final String url;
  final String published;
  final String modified;
  final String author;

  @JsonKey(includeFromJson: false, includeToJson: false)
  RxBool isBookmarked; // Make it RxBool

  Article({
    required this.articleSlug,
    required this.title,
    required this.description,
    required this.image,
    required this.url,
    required this.published,
    required this.modified,
    required this.author,
    bool isBookmarked = false,
  }) : isBookmarked = isBookmarked.obs; // Initialize as RxBool

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
