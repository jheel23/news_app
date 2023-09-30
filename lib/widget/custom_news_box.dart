import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/API/top_news_provider.dart';
import 'package:news_app/screens/top_news_details.dart';
import 'package:smooth_corner/smooth_corner.dart';

class TopNewsBox extends ConsumerWidget {
  const TopNewsBox(
      {super.key, this.title, this.description, this.urlToImage, this.url});
  final String? title;
  final String? description;
  final String? urlToImage;
  final String? url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          TopNewsDetailScreen.routeName,
          arguments: ref.read(newsProvider).findByUrl(url!),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Stack(children: [
          Positioned.fill(
            child: SmoothClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                urlToImage ?? "https://picsum.photos/200/300",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    title ?? "Title",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description ?? "Loading...",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
