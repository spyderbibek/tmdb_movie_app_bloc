import 'package:flutter/cupertino.dart';
/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */

import 'package:movie_app/repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:movie_app/model/movie_response.dart';

class MoviesListByGenreBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getMoviesByGenre(int id) async {
    MovieResponse response = await _repository.getMoviesByGenre(id);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final moviesByGenreBloc = MoviesListByGenreBloc();
