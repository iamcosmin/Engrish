import 'dart:convert';

import '../Core.dart';
import 'package:http/http.dart' as http;

class ServerUpdater {
  int version;
  String versionName;
  String changelog;
  bool mandatory;

  ServerUpdater(
      {this.changelog, this.mandatory, this.version, this.versionName});

  factory ServerUpdater.fromJson(Map<int, dynamic> json) {
    return ServerUpdater(
      version: json['version'] as int,
      versionName: json['version_name'] as String,
      changelog: json['changelog'] as String,
      mandatory: json['mandatory'] as bool,
    );
  }
}

class Update extends Core {
  Future check() async {
    var link = 'https://engrish.web.app/update.json';
    var res = await http
        .get(Uri.encodeFull(link), headers: {'Accept': 'application/json'});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data as List;
      var list = await rest
          .map<ServerUpdater>((json) => ServerUpdater.fromJson(json))
          .toList();
      return list;
    }
    check().
  }
}
