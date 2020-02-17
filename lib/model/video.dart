/**
 * Author: Bibek Shah
 * profile: https://github.com/spyderbibek
 */
import 'package:flutter/material.dart';

class Video {
  String id;
  String key;
  String name;
  String site;
  int size;
  String type;

  Video({this.id, this.key, this.name, this.site, this.size, this.type});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    name = json['name'];
    site = json['site'];
    size = json['size'];
    type = json['type'];
  }
}
