/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */
import 'package:flutter/material.dart';
import 'package:movie_app/widgets/home_app_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:movie_app/style/theme.dart' as Style;

class YoutubePlayerScreen extends StatefulWidget {
  final String videoId;
  final String videoName;

  YoutubePlayerScreen({@required this.videoId, @required this.videoName});

  @override
  _YoutubePlayerScreenState createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        forceHideAnnotation: true,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.CustomColors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.CustomColors.mainColor,
        title: Text(
          '${widget.videoName}',
          maxLines: 2,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Style.CustomColors.secondColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Center(
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.amber,
                progressColors: ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent,
                ),
                onReady: () {
                  print('Player is ready.');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
