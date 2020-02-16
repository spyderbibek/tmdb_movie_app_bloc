/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */

import 'package:movie_app/repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:movie_app/model/genre_response.dart';

class GenreListBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<GenreResponse> _subject =
      BehaviorSubject<GenreResponse>();

  getGenre() async {
    GenreResponse response = await _repository.getGenres();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<GenreResponse> get subject => _subject;
}

final genresBloc = GenreListBloc();
