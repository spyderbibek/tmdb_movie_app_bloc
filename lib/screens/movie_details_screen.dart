import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/bloc/get_genre_bloc.dart';
import 'package:movie_app/model/genre.dart';
import 'package:movie_app/model/genre_response.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/style/theme.dart' as Style;
import 'package:movie_app/widgets/genre_list.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;
  final String heroId;

  MovieDetailsScreen({@required this.movie, @required this.heroId});

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  List<Genre> _genres;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    genresBloc..getGenre();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                widget.movie.backPoster == null
                    ? Image.asset(
                        'assets/images/no-image.jpg',
                        fit: BoxFit.cover,
                      )
                    : FadeInImage(
                        width: double.infinity,
                        height: double.infinity,
                        image: CachedNetworkImageProvider(
                          "https://image.tmdb.org/t/p/original/" +
                              widget.movie.backPoster,
                        ),
                        fit: BoxFit.cover,
                        placeholder: AssetImage("assets/images/no_image.jpg"),
                      ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(
                          begin: FractionalOffset.bottomCenter,
                          end: FractionalOffset.topCenter,
                          colors: [
                            Style.Colors.mainColor,
                            Style.Colors.mainColor.withOpacity(0.3),
                            Style.Colors.mainColor.withOpacity(0.2),
                            Style.Colors.mainColor.withOpacity(0.1),
                          ],
                          stops: [
                            0.0,
                            0.25,
                            0.5,
                            0.75
                          ])),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Style.Colors.mainColor,
            ),
          )
        ],
      ),
      Column(
        children: <Widget>[
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Style.Colors.secondColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Expanded(
              child: Container(
                  color: Colors.transparent,
                  child: Stack(
                    children: <Widget>[
                      SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 75, 16, 16),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              color: Style.Colors.thirdColor,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 120.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            widget.movie.title,
                                            style: TextStyle(
                                                fontFamily: 'Sans',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 24),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    (widget.movie.rating)
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  RatingBar(
                                                    itemSize: 10.0,
                                                    initialRating:
                                                        widget.movie.rating,
                                                    minRating: 1,
                                                    maxRating: 10,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 10,
                                                    itemPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 2.0),
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                      EvaIcons.star,
                                                      color: Style
                                                          .Colors.secondColor,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      print(rating);
                                                    },
                                                  )
                                                ],
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Column(
                                        children: <Widget>[
                                          StreamBuilder<GenreResponse>(
                                            stream: genresBloc.subject.stream,
                                            builder: (BuildContext context,
                                                AsyncSnapshot<GenreResponse>
                                                    snapshot) {
                                              if (snapshot.hasData) {
                                                return GenreList(
                                                  themeData: Theme.of(context),
                                                  genres: widget.movie.genreIds,
                                                  totalGenres:
                                                      snapshot.data.genres,
                                                );
                                              } else {
                                                return CircularProgressIndicator();
                                              }
                                            },
                                          ),

                                          Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  'Overview',
                                                  style: TextStyle(
                                                      fontFamily: 'Sans',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              widget.movie.overview,
                                              style: TextStyle(
                                                  fontFamily: 'Sans',
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, bottom: 4.0),
                                                child: Text(
                                                  'Release date : ${widget.movie.releaseDate}',
                                                  style: TextStyle(
                                                      fontFamily: 'Sans',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
//                                          ScrollingArtists(
//                                            api: Endpoints.getCreditsUrl(
//                                                widget.movie.id),
//                                            title: 'Cast',
//                                            tapButtonText: 'See full cast & crew',
//                                            themeData: widget.themeData,
//                                            onTap: (Cast cast) {
//                                              modalBottomSheetMenu(cast);
//                                            },
//                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                      Positioned(
                        top: 0,
                        left: 40,
                        child: Hero(
                          tag: widget.heroId,
                          child: SizedBox(
                            width: 100,
                            height: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: widget.movie.poster == null
                                  ? Image.asset(
                                      'assets/images/na.jpg',
                                      fit: BoxFit.cover,
                                    )
                                  : FadeInImage(
                                      image: NetworkImage(
                                          'https://image.tmdb.org/t/p/w500/' +
                                              widget.movie.poster),
                                      fit: BoxFit.cover,
                                      placeholder: AssetImage(
                                          'assets/images/no_image.jpg'),
                                    ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )))
        ],
      ),
    ]));
  }

//  return StreamBuilder<GenreResponse>(
//  stream: genresBloc.subject.stream,
//  builder: (BuildContext context, AsyncSnapshot<GenreResponse> snapshot) {
//  if (snapshot.hasData) {
//  return _buildGenreWidget(snapshot.data);
//  } else if (snapshot.hasError) {
//  return _buildErrorWidget(snapshot.error);
//  } else {
//  return _buildLoadingWidget();
//  }
//  },
//  );

}
