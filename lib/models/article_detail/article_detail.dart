import 'package:json_annotation/json_annotation.dart';

part 'article_detail.g.dart';

@JsonSerializable()
class ArticleDetail {
  final String slug;
  final String title;
  final String content;
  final String image;
  final Author author;
  final String modified;

  ArticleDetail({
    required this.slug,
    required this.title,
    required this.content,
    required this.image,
    required this.author,
    required this.modified,
  });

  factory ArticleDetail.fromJson(Map<String, dynamic> json) => _$ArticleDetailFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleDetailToJson(this);
}

@JsonSerializable()
class Author {
  final String slug;
  final String name;

  Author({
    required this.slug,
    required this.name,
  });

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}
