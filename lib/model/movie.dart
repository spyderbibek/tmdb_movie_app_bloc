/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */

//class Movie {
//  int id;
//  double popularity;
//  String title;
//  String backPoster;
//  String poster;
//  String overview;
//  double rating;
//  String error;
//  String release_date;
//
//  Movie(this.id, this.popularity, this.title, this.backPoster, this.poster,
//      this.overview, this.rating, this.error, this.release_date);
//
//  Movie.fromJson(Map<String, dynamic> json)
//      : id = json['id'],
//        error = '',
//        popularity = json['popularity'],
//        title = json['title'],
//        backPoster = json['backdrop_path'],
//        poster = json['poster_path'],
//        overview = json['overview'],
//        release_date = json['release_date'],
//        rating = json['vote_average'].toDouble();
//
//  Movie.withError(String errorValue) : error = errorValue;
//}

class Movie {
  double popularity;
  int voteCount;
  bool video;
  String poster;
  int id;
  bool adult;
  String backPoster;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double rating;
  String overview;
  String releaseDate;
  String error;

  Movie(
      {this.popularity,
      this.voteCount,
      this.video,
      this.poster,
      this.id,
      this.adult,
      this.backPoster,
      this.originalLanguage,
      this.originalTitle,
      this.genreIds,
      this.title,
      this.rating,
      this.error,
      this.overview,
      this.releaseDate});

  Movie.fromJson(Map<String, dynamic> json) {
    popularity = json['popularity'].toDouble();
    error = '';
    voteCount = json['vote_count'];
    video = json['video'];
    poster = json['poster_path'];
    id = json['id'];
    adult = json['adult'];
    backPoster = json['backdrop_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    title = json['title'];
    rating = json['vote_average'].toDouble();
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  Movie.withError(String errorValue) : error = errorValue;
}
