import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/API/recent_news_provider.dart';
import 'package:news_app/screens/top_news_details.dart';
import 'package:smooth_corner/smooth_corner.dart';

class AllNewsWidgets extends ConsumerWidget {
  const AllNewsWidgets({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchedNews = ref.watch(allnewsProvider);
    return searchedNews.isEmpty
        ? const Center(
            child: Text("No News found!", style: TextStyle(fontSize: 18)),
          )
        : ListView.builder(
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  TopNewsDetailScreen.routeName,
                  arguments: ref
                      .read(allnewsProvider.notifier)
                      .findByUrl(searchedNews[index].url!),
                );
              },
              child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  height: 150,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 150,
                        width: 120,
                        child: SmoothClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            searchedNews[index].urlToImage ??
                                'https://picsum.photos/200/300',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                searchedNews[index].title ?? "Loading...",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                searchedNews[index].description ?? "Loading...",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: const TextStyle(fontSize: 8),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                searchedNews[index].author ?? "Loading...",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.black.withOpacity(0.8)),
                              ),
                              const SizedBox(height: 5),
                              const Divider(
                                color: Colors.black,
                                thickness: 0.6,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            itemCount: searchedNews.length,
          );
  }
}
