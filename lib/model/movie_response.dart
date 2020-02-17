/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */
import 'package:movie_app/model/movie.dart';

class MovieResponse {
  List<Movie> movies;
  int page;
  int totalPages;
  String error;

  MovieResponse(this.page, this.totalPages, this.movies, this.error);

  MovieResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalPages = json['total_pages'];
    error = "";
    if (json['results'] != null) {
      movies = new List<Movie>();
      json['results'].forEach((v) {
        movies.add(new Movie.fromJson(v));
      });
    }
  }

  MovieResponse.withError(String errorValue)
      : movies = List(),
        error = errorValue;
}
