import 'dart:convert';
import 'package:http/http.dart' as htp;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/model/news_model.dart';

class TopNewsNotifier {
  final currentDate = DateTime.now();
  final List<News> loadednews = [];
  News findByUrl(String url) {
    return loadednews.firstWhere((element) => element.url == url);
  }

  Future<List<News>> fetchTopNews() async {
    String formattedCurrentDate =
        "${currentDate.year}-${currentDate.month}-${currentDate.day}";
    String lastWeekDate =
        "${currentDate.year}-${currentDate.month}-${currentDate.day - 7}";

    var url =
        "https://newsapi.org/v2/top-headlines?country=in&from=$lastWeekDate&to=$formattedCurrentDate&sortBy=Popularity&apiKey=534e9fc7113c44c7b18532a56678ee61";
    try {
      var response = await htp.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      await extractedData['articles'].forEach((newsData) {
        loadednews.add(News(
          author: newsData['author'],
          content: newsData['content'],
          publishedAt: newsData['publishedAt'],
          url: newsData['url'],
          title: newsData['title'],
          description: newsData['description'],
          urlToImage: newsData['urlToImage'],
        ));
      });
      return loadednews;
    } catch (error) {
      rethrow;
    }
  }
}

final newsProvider = Provider<TopNewsNotifier>((ref) {
  return TopNewsNotifier();
});
final futureNewsProvider =
    FutureProvider((ref) => ref.read(newsProvider).fetchTopNews());
