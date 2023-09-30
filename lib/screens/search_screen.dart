import 'package:flutter/material.dart';
import 'package:news_app/widget/all_news_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  static const routeName = "/search-news-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          scrolledUnderElevation: 0.0,
          title: const Text("Search Result", style: TextStyle(fontSize: 18)),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon:
                const Opacity(opacity: 0.8, child: Icon(Icons.arrow_back_ios)),
          )),
      body: const AllNewsWidgets(),
    );
  }
}
