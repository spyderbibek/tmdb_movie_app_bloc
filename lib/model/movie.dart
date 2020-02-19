/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */

class Movie {
  int id;
  double popularity;
  String title;
  String backPoster;
  String poster;
  String overview;
  double rating;
  String error;

  Movie(this.id, this.popularity, this.title, this.backPoster, this.poster,
      this.overview, this.rating, this.error);

  Movie.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        error = '',
        popularity = json['popularity'],
        title = json['title'],
        backPoster = json['backdrop_path'],
        poster = json['poster_path'],
        overview = json['overview'],
        rating = json['vote_average'].toDouble();

  Movie.withError(String errorValue) : error = errorValue;
}
