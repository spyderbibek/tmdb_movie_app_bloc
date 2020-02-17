import 'package:eva_icons_flutter/eva_icons_flutter.dart';
/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/bloc/get_movies_bloc.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/style/theme.dart' as Style;

class TopRatedMoviesListScreen extends StatefulWidget {
  @override
  _TopRatedMoviesListScreenState createState() =>
      _TopRatedMoviesListScreenState();
}

class _TopRatedMoviesListScreenState extends State<TopRatedMoviesListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moviesBloc..getMovies(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Style.Colors.mainColor,
        appBar: AppBar(
          backgroundColor: Style.Colors.mainColor,
          centerTitle: true,
          title: Text("Top Rates Movies"),
        ),
        body: StreamBuilder<MovieResponse>(
          stream: moviesBloc.subject.stream,
          builder:
              (BuildContext context, AsyncSnapshot<MovieResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return _buildErrorWidget(snapshot.data.error);
              }
              return new GridView.builder(
                padding: EdgeInsets.only(
                  top: 5.0,
                ), // EdgeInsets.only
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                ), // SliverGridDelegateWithFixedCrossAxisCount
                itemCount: snapshot.data.movies.length,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return _buildMovie(snapshot.data.movies[index]);
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
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
      child: Column(
        children: <Widget>[
          movie.poster == null
              ? Container(
                  width: 120.0,
                  height: 200.0,
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
                  width: 100.0,
                  height: 160.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://image.tmdb.org/t/p/w200/" +
                                  movie.poster),
                          fit: BoxFit.cover)),
                ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            width: 100.0,
            child: Text(
              movie.title,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                movie.rating.toString(),
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
