import 'package:anim_search_bar/anim_search_bar.dart';

import 'package:flutter/material.dart';
import 'package:movarsh/constant/theme.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchValue = '';
  Key _key = GlobalKey();
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
              child: AnimSearchBar(
                  key: _key,
                  width: 400,
                  textController: _searchController,
                  onSuffixTap: () {
                    _searchController.clear();
                  })),
        ));
  }
}
