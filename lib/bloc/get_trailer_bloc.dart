import 'package:movie_app/model/trailer_response.dart';
import 'package:movie_app/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */
class TrailerBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<TrailerResponse> _subject =
      BehaviorSubject<TrailerResponse>();

  getTrailers(int movieId) async {
    TrailerResponse trailerResponse =
        await _repository.getMovieTrailer(movieId);
    _subject.sink.add(trailerResponse);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<TrailerResponse> get subject => _subject;
}

final trailerBloc = TrailerBloc();
