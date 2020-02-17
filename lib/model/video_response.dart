/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */
import 'package:movie_app/model/video.dart';

class VideoResponse {
  int id;
  List<Video> video;
  String error;

  VideoResponse({this.id, this.video, this.error});

  VideoResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    error = "";
    if (json['results'] != null) {
      video = new List<Video>();
      json['results'].forEach((v) {
        video.add(new Video.fromJson(v));
      });
    }
  }

  VideoResponse.withError(String errorValue)
      : video = List(),
        error = errorValue;
}
