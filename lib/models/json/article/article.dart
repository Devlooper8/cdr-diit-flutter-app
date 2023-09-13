import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable(explicitToJson: true)
class Article {
  @JsonKey(name: '@context')
  final String context;
  @JsonKey(name: "@graph")
  final List<Graph> graph;

  const Article({required this.context, required this.graph});

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
@JsonSerializable(explicitToJson: true)
class Graph {
  @JsonKey(name: '@type')
  final String type;
  @JsonKey(name: 'headline')
  final String headline;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'author')
  final Author author;
  @JsonKey(name: 'publisher')
  final Publisher publisher;
  @JsonKey(name: 'image')
  final Image image;
  @JsonKey(name: 'datePublished')
  final String datePublished;
  @JsonKey(name: 'dateModified')
  final String dateModified;
  @JsonKey(name: 'mainEntityOfPage')
  final String mainEntityOfPage;
  @JsonKey(name: 'about')
  final String about;

  const Graph(
      {required this.type,
        required this.headline,
        required this.name,
        required this.description,
        required this.author,
        required this.publisher,
        required this.image,
        required this.datePublished,
        required this.dateModified,
        required this.mainEntityOfPage,
        required this.about});

  factory Graph.fromJson(Map<String, dynamic> json) => _$GraphFromJson(json);

  Map<String, dynamic> toJson() => _$GraphToJson(this);
}

@JsonSerializable()
class Author {
  @JsonKey(name: '@type')
  final String type;
  @JsonKey(name: 'name')
  final String name;

  const Author({required this.type,required this.name});


  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}

@JsonSerializable()
class Publisher {
  @JsonKey(name: '@type')
  final String type;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'url')
  final String url;

  const Publisher({required this.type,required this.name,required this.url});

  factory Publisher.fromJson(Map<String, dynamic> json) => _$PublisherFromJson(json);

  Map<String, dynamic> toJson() => _$PublisherToJson(this);
}

@JsonSerializable()
class Image {
  @JsonKey(name: '@type')
  final String type;
  @JsonKey(name: 'url')
  final String url;

  const Image({required this.type, required this.url});

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}
