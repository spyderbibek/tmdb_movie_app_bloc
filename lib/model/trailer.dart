/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */
class Trailer {
  String id;
  String key;
  String name;
  String site;
  Trailer({this.id, this.key, this.name, this.site});

  Trailer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    name = json['name'];
    site = json['site'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['name'] = this.name;
    data['site'] = this.site;
    return data;
  }
}
