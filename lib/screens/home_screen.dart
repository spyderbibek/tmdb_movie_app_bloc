import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */
import 'package:flutter/material.dart';

import 'package:movie_app/style/theme.dart' as Style;
import 'package:movie_app/widgets/genres.dart';
import 'package:movie_app/widgets/home_app_bar.dart';
import 'package:movie_app/widgets/now_playing.dart';
import 'package:movie_app/widgets/persons.dart';
import 'package:movie_app/widgets/top_movies.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum MoviesType { NOWPLAYING, TOPRATED, UPCOMING }

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
//      appBar: AppBar(
//        backgroundColor: Style.Colors.mainColor,
//        centerTitle: true,
//        title: Text("TRENDING"),
//      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Container(
              child: ListView(
                children: <Widget>[
                  HomeAppBar(),
                  NowPlaying(),
                  //GenresScreen()
                  // ,
                  MoviesList(
                    type: MoviesType.TOPRATED,
                  ),
                  PersonsList(),
                  MoviesList(
                    type: MoviesType.UPCOMING,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Text(
                      "MADE BY BKSAPPS",
                      style: TextStyle(
                          color: Style.Colors.titleColor,
                          fontSize: 9.0,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.green,
            ),
            Container(
              color: Colors.blue,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Style.Colors.mainColor,
        showElevation: true,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('Trending'), icon: Icon(EvaIcons.homeOutline)),
          BottomNavyBarItem(
              title: Text('Discover'), icon: Icon(EvaIcons.mapOutline)),
          BottomNavyBarItem(
              title: Text('Calendar'), icon: Icon(EvaIcons.calendarOutline)),
          BottomNavyBarItem(
              title: Text('Profile'), icon: Icon(EvaIcons.personOutline)),
        ],
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
