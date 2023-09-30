import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/API/top_news_provider.dart';
import 'package:news_app/screens/search_screen.dart';
import 'package:news_app/screens/top_news_details.dart';
import 'package:news_app/theme/theme_constant.dart';
import 'package:news_app/widget/custom_news_box.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/widget/custom_search_bar.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: themeData,
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        TopNewsDetailScreen.routeName: (context) => const TopNewsDetailScreen(),
        SearchScreen.routeName: (context) => const SearchScreen(),
      },
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newswatcher = ref.watch(futureNewsProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        scrolledUnderElevation: 0.0,
        title: const PreferredSize(
          preferredSize: Size.fromHeight(24),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CustomSearchBar(),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          newswatcher.when(
            data: (data) {
              return Expanded(
                child: PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return TopNewsBox(
                      title: data[index].title,
                      description: data[index].description,
                      urlToImage: data[index].urlToImage,
                      url: data[index].url,
                    );
                  },
                  itemCount: data.length,
                ),
              );
            },
            error: (error, stackTrace) {
              return const Center(
                child: Text("Error"),
              );
            },
            loading: () {
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) =>
                      Lottie.asset('assets/animations/skeleton_loading.json'),
                  itemCount: 7,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
