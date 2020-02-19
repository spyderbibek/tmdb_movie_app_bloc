import 'package:eva_icons_flutter/eva_icons_flutter.dart';
/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/bloc/get_movies_bloc.dart';
import 'package:movie_app/style/theme.dart' as Style;

class AllMoviesListScreen extends StatefulWidget {
  final MoviesType type;

  AllMoviesListScreen({@required this.type});

  @override
  _AllMoviesListScreenState createState() =>
      _AllMoviesListScreenState(movieType: type);
}

class _AllMoviesListScreenState extends State<AllMoviesListScreen> {
  final MoviesType movieType;
  ScrollController _controller;
  int currentPage = 1;
  Stream<List<Movie>> stream;

  _AllMoviesListScreenState({@required this.movieType});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (movieType == MoviesType.UPCOMING) {
      moviesListBloc..getPaginatedUpcomingMovies(currentPage);
      stream = moviesListBloc.subjectUpcoming.stream;
    } else if (movieType == MoviesType.TOPRATED) {
      moviesListBloc..getPaginatedTopRatedMovies(currentPage);
      stream = moviesListBloc.subjectTopRated.stream;
    }

    _controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      currentPage = currentPage + 1;
      if (movieType == MoviesType.UPCOMING) {
        moviesListBloc..getPaginatedUpcomingMovies(currentPage);
      } else if (movieType == MoviesType.TOPRATED) {
        moviesListBloc..getPaginatedTopRatedMovies(currentPage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Style.Colors.mainColor,
        appBar: AppBar(
          backgroundColor: Style.Colors.mainColor,
          centerTitle: true,
          title: Text("${movieType.toString().split('.').last} MOVIES"),
        ),
        body: StreamBuilder<List<Movie>>(
          stream: stream,
          builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
            if (snapshot.hasData) {
              return new GridView.builder(
                controller: _controller,
                padding: EdgeInsets.only(
                  top: 5.0,
                ), // EdgeInsets.only
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                ), // SliverGridDelegateWithFixedCrossAxisCount
                itemCount: snapshot.data.length,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return _buildMovie(snapshot.data[index]);
                },
              );
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error);
            } else {
              return _buildLoadingWidget();
            }
          },
        ));
  }

  Widget _buildMovie(Movie movie) {
    return Padding(
      padding:
          EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0, left: 10.0),
      child: Stack(
        children: <Widget>[
          movie.poster == null
              ? Container(
                  width: 100.0,
                  height: 160.0,
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
                          image: NetworkImage(
                              "https://image.tmdb.org/t/p/w200/" +
                                  movie.poster),
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
                        movie.title,
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
                            movie.rating.toString(),
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
                            initialRating: movie.rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
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
//          SizedBox(
//            height: 10.0,
//          ),
//          Container(
//            width: 100.0,
//            child: Text(
//              movie.title,
//              maxLines: 2,
//              style: TextStyle(
//                  height: 1.4,
//                  color: Colors.white,
//                  fontWeight: FontWeight.bold,
//                  fontSize: 11.0),
//            ),
//          ),
//          SizedBox(
//            height: 5.0,
//          ),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Text(
//                movie.rating.toString(),
//                style: TextStyle(
//                    color: Colors.white,
//                    fontSize: 10.0,
//                    fontWeight: FontWeight.bold),
//              ),
//              SizedBox(
//                width: 5.0,
//              ),
//              RatingBar(
//                itemSize: 8.0,
//                initialRating: movie.rating,
//                minRating: 1,
//                direction: Axis.horizontal,
//                allowHalfRating: true,
//                itemCount: 5,
//                itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
//                itemBuilder: (context, _) => Icon(
//                  EvaIcons.star,
//                  color: Style.Colors.secondColor,
//                ),
//                onRatingUpdate: (rating) {
//                  print(rating);
//                },
//              )
//            ],
//          )
        ],
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4.0,
            ),
          )
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
