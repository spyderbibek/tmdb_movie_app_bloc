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
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/screens/all_movies_lists.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/screens/all_movies_list.dart';
import 'package:movie_app/screens/movie_details_screen.dart';
import 'package:movie_app/style/theme.dart' as Style;

import 'loader.dart';

class HomeMoviesList extends StatefulWidget {
  final MoviesType type;

  HomeMoviesList({@required this.type});

  @override
  _HomeMoviesListState createState() => _HomeMoviesListState(movieType: type);
}

class _HomeMoviesListState extends State<HomeMoviesList> {
  final MoviesType movieType;
  Stream<List<Movie>> stream;

  _HomeMoviesListState({@required this.movieType});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (movieType == MoviesType.UPCOMING) {
      moviesBloc..getUpcomingMovies(1);
      stream = moviesBloc.subjectUpcoming.stream;
    } else if (movieType == MoviesType.TOPRATED) {
      moviesBloc..getTopRatedMovies(1);
      stream = moviesBloc.subjectTopRated.stream;
    } else if (movieType == MoviesType.POPULAR) {
      moviesBloc..getPopularMovies(1);
      stream = moviesBloc.subjectPopular.stream;
    } else if (movieType == MoviesType.TRENDING) {
      moviesBloc..getTrendingMovie(1);
      stream = moviesBloc.subjectTrending.stream;
    } else if (movieType == MoviesType.NOWPLAYING) {
      moviesBloc..getPlayingMovies(1);
      stream = moviesBloc.subjectPlaying.stream;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10.0, top: 20.0),
              child: Text(
                "${movieType.toString().split('.').last} MOVIES",
                style: TextStyle(
                    color: Style.Colors.titleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return AllMoviesList(type: movieType);
                }));
              },
              child: Padding(
                padding: EdgeInsets.only(right: 10.0, top: 20.0),
                child: Text(
                  "SEE MORE >",
                  style: TextStyle(
                      color: Style.Colors.titleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
        StreamBuilder<List<Movie>>(
          stream: stream,
          builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
            if (snapshot.hasData) {
              return _buildMoviesWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error);
            } else {
              return _buildLoadingWidget();
            }
          },
        )
      ],
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

  Widget _buildMoviesWidget(List<Movie> data) {
    List<Movie> movies = data;
    if (movies.length == 0) {
      return Container(
        child: Text("No Movies"),
      );
    } else {
      return Container(
        height: 270.0,
        padding: EdgeInsets.only(left: 10.0),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsScreen(
                          movie: movies[index],
                          heroId: "${movies[index].id}",
                        ),
                      ));
                },
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
                  child: Column(
                    children: <Widget>[
                      movies[index].poster == null
                          ? Container(
                              width: 120.0,
                              height: 180.0,
                              decoration: BoxDecoration(
                                  color: Style.Colors.secondColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.0)),
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
                              width: 120.0,
                              height: 180.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.0)),
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          "https://image.tmdb.org/t/p/w200/" +
                                              movies[index].poster),
                                      fit: BoxFit.cover)),
                            ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: 100.0,
                        child: Text(
                          movies[index].title,
                          maxLines: 2,
                          style: TextStyle(
                              height: 1.4,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.0),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            movies[index].rating.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          RatingBar(
                            itemSize: 8.0,
                            initialRating: movies[index].rating,
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
              );
            }),
      );
    }
  }
}
