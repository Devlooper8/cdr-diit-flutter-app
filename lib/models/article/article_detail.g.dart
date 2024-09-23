// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleDetail _$ArticleDetailFromJson(Map<String, dynamic> json) =>
    ArticleDetail(
      slug: json['slug'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      image: json['image'] as String,
      author: Author.fromJson(json['author'] as Map<String, dynamic>),
      modified: json['modified'] as String,
    );

Map<String, dynamic> _$ArticleDetailToJson(ArticleDetail instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'title': instance.title,
      'content': instance.content,
      'image': instance.image,
      'author': instance.author,
      'modified': instance.modified,
    };

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      slug: json['slug'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'slug': instance.slug,
      'name': instance.name,
    };
