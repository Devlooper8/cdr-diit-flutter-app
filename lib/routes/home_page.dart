import 'package:cdr_app/models/providers/article_model.dart';
import 'package:cdr_app/widgets/image_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HTML Parsing in Flutter'),
      ),
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () async {
          // You can add loading indicators or error handling here
           final articleModel = context.read<ArticleModel>();
           await articleModel.fetchData();
        },
        child: Consumer<ArticleModel>(
          builder: (context, articleModel, child) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: articleModel.jsonDataList.length, // Adjust as needed
              itemBuilder: (context, index) {
                final article = articleModel.jsonDataList[index];
                final graph = article.graph[0];

                return _KeepAliveImageListTile(
                  imageUrl: graph.image.url,
                  headline: graph.headline,
                  intro: graph.description,
                );
              },
            );
          },
        ),
      ),
    );
  }
}


class _KeepAliveImageListTile extends StatefulWidget {
  const _KeepAliveImageListTile({
    required this.imageUrl,
    required this.headline,
    required this.intro,
    this.onTap, // Add the onTap callback
    this.onBookmarkPressed, // Add the onBookmarkPressed callback
  });

  final String imageUrl;
  final String headline;
  final String intro;
  final VoidCallback? onTap; // Define the onTap callback
  final VoidCallback? onBookmarkPressed; // Define the onBookmarkPressed callback

  @override
  State<_KeepAliveImageListTile> createState() => _KeepAliveImageListTileState();
}

class _KeepAliveImageListTileState extends State<_KeepAliveImageListTile>
    with AutomaticKeepAliveClientMixin<_KeepAliveImageListTile> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Ensure the state is kept alive
    return ImageListTile(
      imageUrl: widget.imageUrl,
      headline: widget.headline,
      intro: widget.intro,
      onTap: widget.onTap, // Pass the onTap callback to ImageListTile
      onBookmarkPressed: widget.onBookmarkPressed, // Pass the onBookmarkPressed callback to ImageListTile
    );
  }
}
