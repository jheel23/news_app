import 'package:flutter/material.dart';
import 'package:news_app/model/news_model.dart';
import 'package:smooth_corner/smooth_corner.dart';

class TopNewsDetailsWidget extends StatelessWidget {
  final News currentNewsDetails;
  const TopNewsDetailsWidget({super.key, required this.currentNewsDetails});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(currentNewsDetails.publishedAt ?? "Loading...",
                    style: TextStyle(
                        fontSize: 13, color: Colors.black.withOpacity(0.8)))
              ],
            ),
            const SizedBox(height: 10),
            Text(
              currentNewsDetails.title ?? "Loading...",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              currentNewsDetails.author ?? "Loading...",
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              child: SmoothClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  currentNewsDetails.urlToImage ??
                      "https://picsum.photos/200/300",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              currentNewsDetails.content ?? "Loading...",
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
