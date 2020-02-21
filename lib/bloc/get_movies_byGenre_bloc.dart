import 'package:flutter/cupertino.dart';
import 'package:movie_app/model/movie.dart';
/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */

import 'package:movie_app/repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:movie_app/model/movie_response.dart';

class MoviesListByGenreBloc {
  List<Movie> _movieData = <Movie>[];
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<List<Movie>> _subject = BehaviorSubject<List<Movie>>();

  getMoviesByGenre(int id, int page) async {
    if (page == 1) _movieData.clear();
    MovieResponse response = await _repository.getMoviesByGenre(id, page);
    _movieData.addAll(response.movies);
    _subject.sink.add(_movieData);
  }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<List<Movie>> get subject => _subject;
}

final moviesByGenreBloc = MoviesListByGenreBloc();
