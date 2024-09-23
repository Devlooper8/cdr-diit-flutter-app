// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleResponse _$ArticleResponseFromJson(Map<String, dynamic> json) =>
    ArticleResponse(
      articles: (json['articles'] as List<dynamic>)
          .map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArticleResponseToJson(ArticleResponse instance) =>
    <String, dynamic>{
      'articles': instance.articles,
    };

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      articleSlug: json['article_slug'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      url: json['url'] as String,
      published: json['published'] as String,
      modified: json['modified'] as String,
      author: json['author'] as String,
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'article_slug': instance.articleSlug,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'url': instance.url,
      'published': instance.published,
      'modified': instance.modified,
      'author': instance.author,
    };
