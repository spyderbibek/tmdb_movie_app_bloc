import 'package:dio/dio.dart';
import 'package:movie_app/model/credit_response.dart';

/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */
import 'package:movie_app/model/genre_response.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/model/personal_response.dart';
import 'package:movie_app/model/trailer_response.dart';
import 'package:movie_app/model/video_response.dart';

class MovieRepository {
  final String apiKey = "a0fda8414a6b4a0f3c552beeea551858";
  static String mainUrl = "https://api.themoviedb.org/3";
  static String imageUrl = "https://image.tmdb.org/t/p/";
  final Dio _dio = Dio();
  var getPlayingUrl = '$mainUrl/movie/now_playing';
  var getTrendingUrl = "$mainUrl/trending/movie/week";
  var getPopularUrl = "$mainUrl/movie/popular";
  var getTopRatedUrl = '$mainUrl/movie/top_rated';
  var getUpcomingUrl = '$mainUrl/movie/upcoming';

  var getMoviesUrl = '$mainUrl/discover/movie';
  var getGenresUrl = "$mainUrl/genre/movie/list";
  var getPersonsUrl = "$mainUrl/trending/person/week";
  var getMovieVideoUrl = "$mainUrl/movie/";

  static String getMovieCreditsUrl(int movieId) {
    return '$mainUrl' + '/movie/$movieId/credits';
  }

  static String movieTrailerUrl(int movieId) {
    return '$mainUrl/movie/$movieId/videos';
  }

//  static String getMoviesForGenre(int genreId, int page) {
//    return '$mainUrl/discover/movie?api_key=$TMDB_API_KEY'
//        '&language=en-US'
//        '&sort_by=popularity.desc'
//        '&include_adult=false'
//        '&include_video=false'
//        '&page=$page'
//        '&with_genres=$genreId';
//  }

  Future<MovieResponse> getPlayingMovies(int page) async {
    var params = {
      "api_key": apiKey,
      "language": "en_US",
      "page": page == null ? 1 : page
    };
    try {
      Response response =
          await _dio.get(getPlayingUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<CreditResponse> getMovieCredits(int movieId) async {
    var params = {"api_key": apiKey};
    try {
      Response response =
          await _dio.get(getMovieCreditsUrl(movieId), queryParameters: params);
      return CreditResponse.fromJsonMap(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return CreditResponse.withError("$error");
    }
  }

  Future<TrailerResponse> getMovieTrailer(int movieId) async {
    var params = {"api_key": apiKey};
    try {
      Response response =
          await _dio.get(movieTrailerUrl(movieId), queryParameters: params);
      return TrailerResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return TrailerResponse.withError("$error");
    }
  }

  Future<MovieResponse> getTrendingMovies(int page) async {
    var params = {
      "api_key": apiKey,
      "language": "en_US",
      "page": page == null ? 1 : page
    };
    try {
      Response response =
          await _dio.get(getTrendingUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieResponse> getPopularMovies(int page) async {
    var params = {
      "api_key": apiKey,
      "language": "en_US",
      "page": page == null ? 1 : page
    };
    try {
      Response response =
          await _dio.get(getPopularUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieResponse> getTopRatedMovies(int page) async {
    var params = {
      "api_key": apiKey,
      "language": "en_US",
      "page": page == null ? 1 : page
    };
    try {
      Response response =
          await _dio.get(getTopRatedUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieResponse> getUpcomingMovies(int page) async {
    var params = {
      "api_key": apiKey,
      "language": "en_US",
      "page": page == null ? 1 : page
    };
    try {
      Response response =
          await _dio.get(getUpcomingUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<VideoResponse> getVideos(int movieId) async {
    var params = {
      "api_key": apiKey,
      "language": "en_US",
    };
    try {
      Response response = await _dio.get(getMovieVideoUrl + "$movieId+/videos",
          queryParameters: params);
      return VideoResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return VideoResponse.withError("$error");
    }
  }

  Future<GenreResponse> getGenres() async {
    var params = {"api_key": apiKey, "language": "en_US", "page": 1};
    try {
      Response response = await _dio.get(getGenresUrl, queryParameters: params);
      return GenreResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return GenreResponse.withError("$error");
    }
  }

  Future<PersonResponse> getPersons() async {
    var params = {"api_key": apiKey};
    try {
      Response response =
          await _dio.get(getPersonsUrl, queryParameters: params);
      return PersonResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return PersonResponse.withError("$error");
    }
  }

  Future<MovieResponse> getMoviesByGenre(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "en_US",
      "page": 1,
      "with_genres": id
    };
    try {
      Response response = await _dio.get(getMoviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return MovieResponse.withError("$error");
    }
  }
}
