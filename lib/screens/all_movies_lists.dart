import 'package:eva_icons_flutter/eva_icons_flutter.dart';
/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */
import 'package:flutter/material.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/style/theme.dart' as Style;
import 'package:movie_app/widgets/movies_list.dart';

class AllMoviesList extends StatefulWidget {
  final MoviesType type;

  AllMoviesList({@required this.type});

  @override
  _AllMoviesListState createState() => _AllMoviesListState();
}

class _AllMoviesListState extends State<AllMoviesList>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _controller;

  IconData gridIcon = EvaIcons.listOutline;
  bool gridView;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.type == MoviesType.UPCOMING) {
      _controller = TabController(length: 5, vsync: this, initialIndex: 3);
    } else if (widget.type == MoviesType.TOPRATED) {
      _controller = TabController(length: 5, vsync: this, initialIndex: 4);
    } else if (widget.type == MoviesType.NOWPLAYING) {
      _controller = TabController(length: 5, vsync: this, initialIndex: 0);
    } else if (widget.type == MoviesType.TRENDING) {
      _controller = TabController(length: 5, vsync: this, initialIndex: 1);
    } else {
      _controller = TabController(
        length: 5,
        vsync: this,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Style.Colors.mainColor,
              title: Text("Movies",
                  style: TextStyle(color: Style.Colors.secondColor)),
              pinned: false,
              floating: true,
              snap: false,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    gridIcon,
                    color: Style.Colors.secondColor,
                  ),
                  onPressed: () {
                    setState(() {
                      if (gridIcon == EvaIcons.gridOutline) {
                        gridIcon = EvaIcons.listOutline;
                        gridView = false;
                      } else {
                        gridIcon = EvaIcons.gridOutline;
                        gridView = true;
                      }
                    });
                  },
                )
              ],
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                TabBar(
                  indicatorColor: Colors.red,
                  unselectedLabelStyle: TextStyle(fontSize: 12),
                  labelStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  labelColor: Colors.red,
                  unselectedLabelColor: Style.Colors.secondColor,
                  tabs: <Widget>[
                    Tab(
                      text: "Now Playing",
                    ),
                    Tab(
                      text: "Trending",
                    ),
                    Tab(
                      text: "Popular",
                    ),
                    Tab(
                      text: "Upcoming",
                    ),
                    Tab(
                      text: "Top Rated",
                    ),
                  ],
                  controller: _controller,
                  isScrollable: true,
                ),
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: <Widget>[
                  MoviesList(
                    type: MoviesType.NOWPLAYING,
                    gridView: gridIcon == EvaIcons.gridOutline ? true : false,
                  ),
                  MoviesList(
                    type: MoviesType.TRENDING,
                    gridView: gridIcon == EvaIcons.gridOutline ? true : false,
                  ),
                  MoviesList(
                    type: MoviesType.POPULAR,
                    gridView: gridIcon == EvaIcons.gridOutline ? true : false,
                  ),
                  MoviesList(
                    type: MoviesType.UPCOMING,
                    gridView: gridIcon == EvaIcons.gridOutline ? true : false,
                  ),
                  MoviesList(
                    type: MoviesType.TOPRATED,
                    gridView: gridIcon == EvaIcons.gridOutline ? true : false,
                  ),
                ],
                controller: _controller,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Style.Colors.mainColor, // ADD THE COLOR YOU WANT AS BACKGROUND.
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
