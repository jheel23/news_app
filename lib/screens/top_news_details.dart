import 'package:flutter/material.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/widget/top_news_details_widget.dart';

class TopNewsDetailScreen extends StatelessWidget {
  const TopNewsDetailScreen({super.key});
  static const routeName = "/top-news-detail";

  @override
  Widget build(BuildContext context) {
    final currentNewsDetails =
        ModalRoute.of(context)!.settings.arguments as News;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: TopNewsDetailsWidget(currentNewsDetails: currentNewsDetails),
    );
  }
}
