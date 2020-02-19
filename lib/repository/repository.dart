import 'package:dio/dio.dart';

/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */
import 'package:movie_app/model/genre_response.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/model/personal_response.dart';
import 'package:movie_app/model/video_response.dart';

class MovieRepository {
  final String apiKey = "a0fda8414a6b4a0f3c552beeea551858";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();
  var getTopRatedUrl = '$mainUrl/movie/top_rated';
  var getPlayingUrl = '$mainUrl/movie/now_playing';
  var getUpcomingUrl = '$mainUrl/movie/upcoming';
  var getMoviesUrl = '$mainUrl/discover/movie';

  var getGenresUrl = "$mainUrl/genre/movie/list";
  var getPersonsUrl = "$mainUrl/trending/person/week";
  var getMovieVideoUrl = "$mainUrl/movie/";

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

//  Future<Movie> getTempMovies(int page) async {
//    var params = {
//      "api_key": apiKey,
//      "language": "en_US",
//      "page": page == null ? 1 : page
//    };
//    try {
//      Response response =
//          await _dio.get(getPopularUrl, queryParameters: params);
//      return Movie.fromJson(response.data);
//    } catch (error, stackTrace) {
//      print("Exception occured: $error stackTrace: $stackTrace");
////      return Movie.withError("$error");
//    }
//  }

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

//  Future<MovieResponse> getPlayingMovies() async {
//    var params = {"api_key": apiKey, "language": "en_US", "page": 1};
//    try {
//      Response response =
//          await _dio.get(getPlayingUrl, queryParameters: params);
//      return MovieResponse.fromJson(response.data);
//    } catch (error, stackTrace) {
//      print("Exception occured: $error stackTrace: $stackTrace");
//      return MovieResponse.withError("$error");
//    }
//  }

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
