/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app/bloc/get_all_movies_bloc.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/widgets/loader.dart';
import 'package:movie_app/widgets/video_player_bottom_sheet.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:movie_app/style/theme.dart' as Style;

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  void initState() {
    super.initState();

    moviesBloc..getPlayingMovies(1);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Movie>>(
      stream: moviesBloc.subjectPlaying.stream,
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          return _buildHomeWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Loader(),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text("Error occured: $error")],
      ),
    );
  }

  Widget _buildHomeWidget(List<Movie> data) {
    List<Movie> movies = data;
    if (movies.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[Text("No Movies")],
        ),
      );
    } else {
      return Container(
        height: 220,
        child: PageIndicatorContainer(
            align: IndicatorAlign.bottom,
            indicatorSpace: 8.0,
            padding: EdgeInsets.all(5.0),
            indicatorColor: Style.CustomColors.titleColor,
            indicatorSelectorColor: Style.CustomColors.secondColor,
            shape: IndicatorShape.circle(size: 5.0),
            child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.take(5).length,
                itemBuilder: (context, index) {
                  return Theme(
                    data: Theme.of(context)
                        .copyWith(canvasColor: Colors.transparent),
                    child: VideoPlayerBottomSheet(
                      movie: movies[index],
                    ),
                  );
                }),
            length: movies.take(5).length),
      );
    }
  }
}
