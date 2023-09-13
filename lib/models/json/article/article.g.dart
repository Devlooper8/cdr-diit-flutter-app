// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      context: json['@context'] as String,
      graph: (json['@graph'] as List<dynamic>)
          .map((e) => Graph.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      '@context': instance.context,
      '@graph': instance.graph.map((e) => e.toJson()).toList(),
    };

Graph _$GraphFromJson(Map<String, dynamic> json) => Graph(
      type: json['@type'] as String,
      headline: json['headline'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      author: Author.fromJson(json['author'] as Map<String, dynamic>),
      publisher: Publisher.fromJson(json['publisher'] as Map<String, dynamic>),
      image: Image.fromJson(json['image'] as Map<String, dynamic>),
      datePublished: json['datePublished'] as String,
      dateModified: json['dateModified'] as String,
      mainEntityOfPage: json['mainEntityOfPage'] as String,
      about: json['about'] as String,
    );

Map<String, dynamic> _$GraphToJson(Graph instance) => <String, dynamic>{
      '@type': instance.type,
      'headline': instance.headline,
      'name': instance.name,
      'description': instance.description,
      'author': instance.author.toJson(),
      'publisher': instance.publisher.toJson(),
      'image': instance.image.toJson(),
      'datePublished': instance.datePublished,
      'dateModified': instance.dateModified,
      'mainEntityOfPage': instance.mainEntityOfPage,
      'about': instance.about,
    };

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      type: json['@type'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      '@type': instance.type,
      'name': instance.name,
    };

Publisher _$PublisherFromJson(Map<String, dynamic> json) => Publisher(
      type: json['@type'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$PublisherToJson(Publisher instance) => <String, dynamic>{
      '@type': instance.type,
      'name': instance.name,
      'url': instance.url,
    };

Image _$ImageFromJson(Map<String, dynamic> json) => Image(
      type: json['@type'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      '@type': instance.type,
      'url': instance.url,
    };
