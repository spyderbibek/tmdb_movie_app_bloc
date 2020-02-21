import 'package:movie_app/model/cast.dart';
import 'package:movie_app/model/crew.dart';

class CreditResponse {
  int id;
  List<Cast> cast;
  List<Crew> crew;
  String error;

  CreditResponse.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        error = "",
        cast = List<Cast>.from(map["cast"].map((it) => Cast.fromJsonMap(it))),
        crew = List<Crew>.from(map["crew"].map((it) => Crew.fromJsonMap(it)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    error = "";
    data['cast'] =
        cast != null ? this.cast.map((v) => v.toJson()).toList() : null;
    data['crew'] =
        crew != null ? this.crew.map((v) => v.toJson()).toList() : null;
    return data;
  }

  CreditResponse.withError(String errorValue) : error = errorValue;
}
