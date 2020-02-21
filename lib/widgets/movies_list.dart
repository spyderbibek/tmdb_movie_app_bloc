import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/bloc/get_all_movies_bloc.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/style/theme.dart' as Style;
import 'package:movie_app/widgets/loader.dart';

class MoviesList extends StatefulWidget {
  final MoviesType type;
  final bool gridView;

  MoviesList({@required this.type, @required this.gridView});

  @override
  _MoviesListState createState() => _MoviesListState(movieType: type);
}

class _MoviesListState extends State<MoviesList> {
  final MoviesType movieType;
  bool gridView;
  ScrollController _controller;
  int currentPage = 1;
  Stream<List<Movie>> stream;

  _MoviesListState({@required this.movieType});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (movieType == MoviesType.UPCOMING) {
      moviesBloc..getUpcomingMovies(currentPage);
      stream = moviesBloc.subjectUpcoming.stream;
    } else if (movieType == MoviesType.TOPRATED) {
      moviesBloc..getTopRatedMovies(currentPage);
      stream = moviesBloc.subjectTopRated.stream;
    } else if (movieType == MoviesType.NOWPLAYING) {
      moviesBloc..getPlayingMovies(currentPage);
      stream = moviesBloc.subjectPlaying.stream;
    } else if (movieType == MoviesType.TRENDING) {
      moviesBloc..getTrendingMovie(currentPage);
      stream = moviesBloc.subjectTrending.stream;
    } else if (movieType == MoviesType.POPULAR) {
      moviesBloc..getPopularMovies(currentPage);
      stream = moviesBloc.subjectPopular.stream;
    }

    _controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void didUpdateWidget(MoviesList oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.gridView != widget.gridView) {
      setState(() {
        gridView = widget.gridView;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  void _scrollListener() {
    double maxScroll = _controller.position.maxScrollExtent;
    double currentScroll = _controller.position.pixels;
    double delta = 300.0;
    if (maxScroll - currentScroll <= delta) {
      currentPage = currentPage + 1;
      if (movieType == MoviesType.UPCOMING) {
        moviesBloc..getUpcomingMovies(currentPage);
      } else if (movieType == MoviesType.TOPRATED) {
        moviesBloc..getTopRatedMovies(currentPage);
      } else if (movieType == MoviesType.NOWPLAYING) {
        moviesBloc..getPlayingMovies(currentPage);
      } else if (movieType == MoviesType.TRENDING) {
        moviesBloc..getTrendingMovie(currentPage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Style.Colors.mainColor,
      //padding: EdgeInsets.all(8.0),
      child: StreamBuilder<List<Movie>>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return gridView != true
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    controller: _controller,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return _buildMovieInList(snapshot.data[index]);
                    },
                  )
                : GridView.builder(
                    controller: _controller,
                    padding: EdgeInsets.only(
                      top: 5.0,
                    ), // EdgeInsets.only
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                    ), // SliverGridDelegateWithFixedCrossAxisCount
                    itemCount: snapshot.data.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      return _buildMovieInGrid(snapshot.data[index]);
                    },
                  );
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else {
            return _buildLoadingWidget();
          }
        },
      ),
    );
  }

  Widget _buildMovieInGrid(Movie movieData) {
    return Padding(
      padding:
          EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0, left: 10.0),
      child: Stack(
        children: <Widget>[
          movieData.poster == null
              ? Container(
                  width: 170.0,
                  height: 220.0,
                  decoration: BoxDecoration(
                      color: Style.Colors.secondColor,
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      shape: BoxShape.rectangle),
                  child: Column(
                    children: <Widget>[
                      Icon(
                        EvaIcons.filmOutline,
                        color: Colors.white,
                        size: 50.0,
                      )
                    ],
                  ),
                )
              : Container(
                  width: 170.0,
                  height: 220.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              "https://image.tmdb.org/t/p/w200/" +
                                  movieData.poster),
                          fit: BoxFit.cover)),
                ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                //width: 100.0,

                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        movieData.title,
                        maxLines: 2,
                        style: TextStyle(
                            height: 1.4,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            movieData.rating.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          RatingBar(
                            itemSize: 10.0,
                            initialRating: movieData.rating,
                            minRating: 1,
                            maxRating: 10,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 10,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => Icon(
                              EvaIcons.star,
                              color: Style.Colors.secondColor,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMovieInList(Movie movieData) {
    return Padding(
      padding:
          EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0, left: 10.0),
      child: Container(
        width: double.maxFinite,
        height: 150,
        decoration: BoxDecoration(
            color: Style.Colors.thirdColor,
            borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              width: 100,
              height: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    image: movieData.poster != null
                        ? CachedNetworkImageProvider(
                            "https://image.tmdb.org/t/p/w200/" +
                                movieData.poster)
                        : AssetImage("assets/images/no_image.jpg")),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.only(top: 10.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      movieData.title,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          (movieData.rating / 2).toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        RatingBar(
                          itemSize: 10.0,
                          initialRating: movieData.rating,
                          minRating: 1,
                          maxRating: 10,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 10,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (context, _) => Icon(
                            EvaIcons.star,
                            color: Style.Colors.secondColor,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
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
}
