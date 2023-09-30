import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/model/news_model.dart';
import 'package:http/http.dart' as htp;

class AllNewsNotifier extends StateNotifier<List<News>> {
  AllNewsNotifier() : super([]);
  List<News> allnews = [];
  String searchText = "";
  Future<void> setSearchText(String text) async {
    searchText = text;
    allnews = [];
    await fetchAllNews();
  }

  News findByUrl(String url) {
    return state.firstWhere((element) => element.url == url);
  }

  Future<void> fetchAllNews() async {
    var url =
        "https://newsapi.org/v2/everything?q=$searchText&apiKey=534e9fc7113c44c7b18532a56678ee61";
    try {
      var response = await htp.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      await extractedData['articles'].forEach((newsData) {
        allnews.add(News(
          author: newsData['author'],
          content: newsData['content'],
          publishedAt: newsData['publishedAt'],
          url: newsData['url'],
          title: newsData['title'],
          description: newsData['description'],
          urlToImage: newsData['urlToImage'],
        ));
      });
      state = allnews;
    } catch (error) {
      rethrow;
    }
  }
}

final allnewsProvider =
    StateNotifierProvider<AllNewsNotifier, List<News>>((ref) {
  return AllNewsNotifier();
});
