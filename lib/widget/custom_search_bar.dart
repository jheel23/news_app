import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:news_app/API/recent_news_provider.dart';
import 'package:news_app/screens/search_screen.dart';

class CustomSearchBar extends ConsumerStatefulWidget {
  const CustomSearchBar({super.key});

  @override
  ConsumerState<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends ConsumerState<CustomSearchBar> {
  final _keyformSubmit = GlobalKey<FormState>();
  String _searchText = "";

  void _submit() async {
    final navigator = Navigator.of(context);

    final isValid = _keyformSubmit.currentState!.validate();
    if (!isValid) {
      return;
    }
    _keyformSubmit.currentState!.save(); //Saving the form
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            CupertinoActivityIndicator(animating: true, color: Colors.black),
            SizedBox(width: 20),
            Text("Searching...", style: TextStyle(color: Colors.black)),
          ],
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.grey.withOpacity(0.9),
      ),
    );
    await ref.read(allnewsProvider.notifier).setSearchText(_searchText);
    navigator.pushNamed(
      SearchScreen.routeName,
    ); //Navigating to the search screen

    _keyformSubmit.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          const Opacity(opacity: 0.7, child: Icon(Ionicons.search)),
          const SizedBox(width: 10),
          Expanded(
            child: Form(
              key: _keyformSubmit,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter some text";
                  }
                  return null;
                },
                onFieldSubmitted: (_) => _submit(),
                onSaved: (value) {
                  _searchText = value!;
                },
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
