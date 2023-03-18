import 'dart:convert';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movarsh/constant/theme.dart';
import 'package:movarsh/model/moviemodel.dart';
import 'package:movarsh/view/layout/category/Category.dart';
import 'package:movarsh/view/layout/category/tvshowes.dart';
import 'package:movarsh/view/layout/pages/favorite.dart';
import 'package:movarsh/view/layout/pages/movieimfo.dart';
import 'package:movarsh/view/layout/category/moviespage.dart';
import 'package:movarsh/view/layout/pages/searchpage.dart';
import 'package:movarsh/view/layout/pages/settingpage.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

//import 'package:shimmer/shimmer.dart';

import '../../constant/curd.dart';
import '../../constant/database/database.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Sql sqldb = Sql();
  @override
  void initState() {
    // // TODO: implement initState
    _pageController = PageController();

    //  films(['1', 'ar']);
  }

  @override
  void dispose() {
    // TODO: implement dispose _pageController = PageController();
    _pageController.dispose();
  }

  var _currentIndex = 0;

  late PageController _pageController;
  var _currentIndex2 = 0;
  var screen = [
    HomePage(),
    Favorite(),
    Category(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:
            //  _currentIndex == 0
            //     ?
            Scaffold(
      backgroundColor: primaryColor,
      appBar: _currentIndex == 0
          ? AppBar(
              backgroundColor: primaryColor,
              title: buuilTabBar(),
              centerTitle: true,
              elevation: 0,
            )
          : null,
      bottomNavigationBar: buuilBottomBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: [
          _currentIndex2 == 0
              ? MoviesPage()
              : _currentIndex2 == 1
                  ? TvShows()
                  : Category(),
          Favorite(),
          SearchPage(),
          SettingPage()
        ],
      ),
    ));
  }

  buuilBottomBar() {
    return Container(
        child: BottomNavyBar(
      backgroundColor: secondaryColor,
      selectedIndex: _currentIndex,
      showElevation: true, // use this to remove appBar's elevation
      onItemSelected: (index) => setState(() {
        _currentIndex = index;
        _pageController.animateToPage(index,
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      }),
      items: [
        BottomNavyBarItem(
          icon: Icon(Icons.apps),
          title: Text('Home'),
          activeColor: Colors.redAccent,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.favorite),
          title: Text('Favorite'),
          activeColor: Colors.redAccent,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.search),
          title: Text('Search'),
          activeColor: Colors.redAccent,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.settings),
          title: Text('Settings'),
          activeColor: Colors.redAccent,
        ),
      ],
    ));
  }

  buuilTabBar() {
    return Container(
      color: secondaryColor.withOpacity(0),
      child: SalomonBottomBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex2,
        onTap: (i) => setState(() => _currentIndex2 = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.movie),
            title: Text("Movies"),
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.tv),
            title: Text("Tv Shows"),
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.category_rounded),
            title: Text("Category"),
          ),

          /// Profile
        ],
      ),
    );
  }
}
