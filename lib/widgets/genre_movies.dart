import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/bloc/get_movies_byGenre_bloc.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/screens/movie_details_screen.dart';
import 'package:movie_app/style/theme.dart' as Style;
import 'package:movie_app/widgets/home_app_bar.dart';

class GenreMovies extends StatefulWidget {
  final int genreId;
  final String genreName;

  GenreMovies({@required this.genreId, @required this.genreName});

  @override
  _GenreMoviesState createState() =>
      _GenreMoviesState(genreId: genreId, genreName: genreName);
}

class _GenreMoviesState extends State<GenreMovies> {
  final int genreId;
  final String genreName;
  ScrollController _controller;
  int currentPage = 1;
  _GenreMoviesState({@required this.genreId, @required this.genreName});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moviesByGenreBloc..getMoviesByGenre(genreId, currentPage);
    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    double maxScroll = _controller.position.maxScrollExtent;
    double currentScroll = _controller.position.pixels;
    double delta = 300.0;
    if (maxScroll - currentScroll <= delta) {
      currentPage = currentPage + 1;
      moviesByGenreBloc..getMoviesByGenre(genreId, currentPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Style.CustomColors.mainColor,
        appBar: AppBar(
          backgroundColor: Style.CustomColors.mainColor,
          title: Text(
            '$genreName',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              letterSpacing: 1.4,
              color: Style.CustomColors.secondColor,
            ),
          ),
        ),
        body: StreamBuilder<List<Movie>>(
          stream: moviesByGenreBloc.subject.stream,
          builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
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
                  return _buildMoviesByGenreWidget(snapshot.data[index]);
                },
              );
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error);
            } else {
              return _buildLoadingWidget();
            }
          },
        ),
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

  Widget _buildMoviesByGenreWidget(Movie data) {
    return Padding(
      padding:
          EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0, left: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailsScreen(
                  heroTag: "${data.id}+${data.title}",
                  movie: data,
                ),
              ));
        },
        child: Stack(
          children: <Widget>[
            data.poster == null
                ? Hero(
                    tag: "${data.id}+${data.title}",
                    child: Container(
                      width: 170.0,
                      height: 220.0,
                      decoration: BoxDecoration(
                          color: Style.CustomColors.secondColor,
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
                    ),
                  )
                : Hero(
                    tag: "${data.id}+${data.title}",
                    child: FadeInImage(
                      width: 170,
                      height: 220,
                      image: CachedNetworkImageProvider(
                          "https://image.tmdb.org/t/p/w200/" + data.poster),
                      fit: BoxFit.cover,
                      placeholder: AssetImage("assets/images/loading.gif"),
                    ),
                  ),
//            Container(
//                    width: 170.0,
//                    height: 220.0,
//                    decoration: BoxDecoration(
//                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
//                        shape: BoxShape.rectangle,
//                        image: DecorationImage(
//                            image: CachedNetworkImageProvider(
//                                "https://image.tmdb.org/t/p/w200/" +
//                                    data.poster),
//                            fit: BoxFit.cover)),
//                  ),
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
                          data.title,
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
                              data.rating.toString(),
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
                              initialRating: data.rating,
                              minRating: 1,
                              maxRating: 10,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 10,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 2.0),
                              itemBuilder: (context, _) => Icon(
                                EvaIcons.star,
                                color: Style.CustomColors.secondColor,
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
      ),
    );
  }
}
