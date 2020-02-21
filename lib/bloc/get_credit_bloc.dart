/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */
import 'package:movie_app/model/credit_response.dart';
import 'package:movie_app/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class CreditsBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<CreditResponse> _subject =
      BehaviorSubject<CreditResponse>();

  getCredits(int movieId) async {
    CreditResponse creditResponse = await _repository.getMovieCredits(movieId);
    _subject.sink.add(creditResponse);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<CreditResponse> get subject => _subject;
}

final creditBloc = CreditsBloc();
