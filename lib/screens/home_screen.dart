import 'package:eva_icons_flutter/eva_icons_flutter.dart';
/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */
import 'package:flutter/material.dart';
import 'package:movie_app/style/theme.dart' as Style;
import 'package:movie_app/widgets/genres.dart';
import 'package:movie_app/widgets/now_playing.dart';
import 'package:movie_app/widgets/persons.dart';
import 'package:movie_app/widgets/top_movies.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,
        leading: Icon(
          EvaIcons.menu2Outline,
          color: Colors.white,
        ),
        title: Text("Discover"),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: Icon(
                EvaIcons.searchOutline,
                color: Colors.white,
              ))
        ],
      ),
      body: ListView(
        children: <Widget>[
          NowPlaying(),
          GenresScreen(),
          PersonsList(),
          TopMovies(),
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
    );
  }
}
