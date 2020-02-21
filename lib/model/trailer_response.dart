import 'package:movie_app/model/trailer.dart';

/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */
class TrailerResponse {
  int id;
  String error;
  List<Trailer> results;

  TrailerResponse(this.id, this.results, this.error);

  TrailerResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    error = '';
    if (json['results'] != null) {
      results = new List<Trailer>();
      json['results'].forEach((v) {
        results.add(new Trailer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }

  TrailerResponse.withError(String errorValue) : error = errorValue;
}
