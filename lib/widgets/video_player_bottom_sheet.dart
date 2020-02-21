import 'package:cached_network_image/cached_network_image.dart';
/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/bloc/get_video_bloc.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/video_response.dart';
import 'package:movie_app/style/theme.dart' as Style;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerBottomSheet extends StatefulWidget {
  Movie movie;

  VideoPlayerBottomSheet({@required this.movie});

  @override
  _VideoPlayerBottomSheetState createState() =>
      _VideoPlayerBottomSheetState(movie);
}

class _VideoPlayerBottomSheetState extends State<VideoPlayerBottomSheet> {
  Movie movieData;
  _VideoPlayerBottomSheetState(this.movieData);
  String videoId = "isOGD_7hNIY";
  Color color = Colors.amber;
  YoutubePlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = YoutubePlayerController(
      initialVideoId: 'iLnmTe5Q2Qw',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    super.initState();
    movieVideoBloc..getMovieVideos(movieData.id);
  }

  _showModalBottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return StreamBuilder<VideoResponse>(
            stream: movieVideoBloc.subject.stream,
            builder:
                (BuildContext context, AsyncSnapshot<VideoResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0) {
                  return _buildErrorWidget(snapshot.data.error);
                }

                return _buildYoutubePlayer(snapshot.data, context);
              } else if (snapshot.hasError) {
                return _buildErrorWidget(snapshot.error);
              } else {
                return _buildLoadingWidget();
              }
            },
          );
        });
  }

  Widget _buildYoutubePlayer(VideoResponse data, BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      thumbnailUrl: 'https://i3.ytimg.com/vi_webp/${data.video[0].key}/' +
          ThumbnailQuality.standard,
      progressIndicatorColor: Colors.amber,
      progressColors: ProgressBarColors(
        playedColor: Colors.amber,
        handleColor: Colors.amberAccent,
      ),
      topActions: <Widget>[
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            _controller.metadata.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
      onReady: () {
        _controller.load(data.video[0].key);
      },
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showModalBottomSheet(context);
      },
      child: Stack(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: 220,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                        "https://image.tmdb.org/t/p/original/" +
                            movieData.backPoster),
                  ))),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Style.Colors.mainColor.withOpacity(1.0),
                      Style.Colors.mainColor.withOpacity(0.0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.0, 0.9])),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: Icon(
              FontAwesomeIcons.playCircle,
              color: Style.Colors.secondColor,
              size: 40.0,
            ),
          ),
          Positioned(
            bottom: 30.0,
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              width: 250.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    movieData.title,
                    style: TextStyle(
                        height: 1.5,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
