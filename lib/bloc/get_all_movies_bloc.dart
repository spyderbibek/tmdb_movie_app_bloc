/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  List<Movie> _upcomingMovieData = <Movie>[];
  List<Movie> _nowPlayingMovieData = <Movie>[];
  List<Movie> _topRatedMovieData = <Movie>[];
  List<Movie> _trendingMovieData = <Movie>[];
  List<Movie> _popularMovieData = <Movie>[];
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<List<Movie>> _subjectUpcoming =
      BehaviorSubject<List<Movie>>();
  final BehaviorSubject<List<Movie>> _subjectNowPlaying =
      BehaviorSubject<List<Movie>>();
  final BehaviorSubject<List<Movie>> _subjectTopRated =
      BehaviorSubject<List<Movie>>();
  final BehaviorSubject<List<Movie>> _subjectTrending =
      BehaviorSubject<List<Movie>>();
  final BehaviorSubject<List<Movie>> _subjectPopular =
      BehaviorSubject<List<Movie>>();

  getPlayingMovies(int page) async {
    if (page == 1) _nowPlayingMovieData.clear();

    MovieResponse _response = await _repository.getPlayingMovies(page);

//    if (_response != null) {
//      _response.movies.forEach((item) {
//        _nowPlayingMovieData.removeWhere((it) {
//          print("Duplicate Item Deleting: ${it.id == item.id}");
//          return it.id == item.id;
//        });
//        _nowPlayingMovieData.add(item);
//      });
//    }
    _nowPlayingMovieData.addAll(_response.movies);

    _subjectNowPlaying.sink.add(_nowPlayingMovieData);
  }

  getUpcomingMovies(int page) async {
    if (page == 1) _upcomingMovieData.clear();
    MovieResponse _response = await _repository.getUpcomingMovies(page);
    _upcomingMovieData.addAll(_response.movies);
    _subjectUpcoming.sink.add(_upcomingMovieData);
  }

  getTopRatedMovies(int page) async {
    if (page == 1) _topRatedMovieData.clear();
    MovieResponse _response = await _repository.getTopRatedMovies(page);
    _topRatedMovieData.addAll(_response.movies);
    _subjectTopRated.sink.add(_topRatedMovieData);
  }

  getTrendingMovie(int page) async {
    if (page == 1) _trendingMovieData.clear();
    MovieResponse _response = await _repository.getTrendingMovies(page);
    _trendingMovieData.addAll(_response.movies);
    _subjectTrending.sink.add(_trendingMovieData);
  }

  getPopularMovies(int page) async {
    if (page == 1) _popularMovieData.clear();
    MovieResponse _response = await _repository.getPopularMovies(page);
    _popularMovieData.addAll(_response.movies);
    _subjectPopular.sink.add(_popularMovieData);
  }

  dispose() {
    _subjectTopRated.close();
    _subjectUpcoming.close();
    _subjectNowPlaying.close();
    _subjectTrending.close();
    _subjectPopular.close();
    _topRatedMovieData.clear();
    _upcomingMovieData.clear();
    _nowPlayingMovieData.clear();
    _popularMovieData.clear();
    _trendingMovieData.clear();
  }

  BehaviorSubject<List<Movie>> get subjectUpcoming => _subjectUpcoming;
  BehaviorSubject<List<Movie>> get subjectPlaying => _subjectNowPlaying;
  BehaviorSubject<List<Movie>> get subjectTopRated => _subjectTopRated;
  BehaviorSubject<List<Movie>> get subjectTrending => _subjectTrending;
  BehaviorSubject<List<Movie>> get subjectPopular => _subjectPopular;
}

final moviesBloc = MoviesBloc();
