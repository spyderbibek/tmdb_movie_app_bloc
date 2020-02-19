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
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<List<Movie>> _subjectUpcoming =
      BehaviorSubject<List<Movie>>();
  final BehaviorSubject<List<Movie>> _subjectNowPlaying =
      BehaviorSubject<List<Movie>>();
  final BehaviorSubject<List<Movie>> _subjectTopRated =
      BehaviorSubject<List<Movie>>();

//  getMovies(int page, MoviesType type) async {
//    MovieResponse _response;
//    if (type == MoviesType.NOWPLAYING) {
//
//    } else if (type == MoviesType.UPCOMING) {
//      _response = await _repository.getUpcomingMovies(page);
//      _movieData.addAll(_response.movies);
//      _subject.sink.add(_movieData);
//    } else if (type == MoviesType.LATEST) {
//      _response = await _repository.getLatestMovies(page);
//      _movieData.addAll(_response.movies);
//      _subject.sink.add(_movieData);
//    } else if (type == MoviesType.TOPRATED) {
//      _response = await _repository.getPopularMovies(page);
//      _movieData.addAll(_response.movies);
//      _subject.sink.add(_movieData);
//    }
//  }

  getPlayingMovies(int page) async {
    MovieResponse _response = await _repository.getPlayingMovies(page);
    _nowPlayingMovieData.addAll(_response.movies);
    _subjectNowPlaying.sink.add(_nowPlayingMovieData);
  }

  getUpcomingMovies(int page) async {
    MovieResponse _response = await _repository.getUpcomingMovies(page);
    _upcomingMovieData.addAll(_response.movies);
    _subjectUpcoming.sink.add(_upcomingMovieData);
  }

  getPopularMovies(int page) async {
    MovieResponse _response = await _repository.getTopRatedMovies(page);
    _topRatedMovieData.addAll(_response.movies);
    _subjectTopRated.sink.add(_topRatedMovieData);
  }

  dispose() {
    _subjectTopRated.close();
    _subjectUpcoming.close();
    _subjectNowPlaying.close();
    _topRatedMovieData.clear();
    _upcomingMovieData.clear();
    _nowPlayingMovieData.clear();
  }

  BehaviorSubject<List<Movie>> get subjectUpcoming => _subjectUpcoming;
  BehaviorSubject<List<Movie>> get subjectPlaying => _subjectNowPlaying;
  BehaviorSubject<List<Movie>> get subjectTopRated => _subjectTopRated;
}

final moviesBloc = MoviesBloc();
