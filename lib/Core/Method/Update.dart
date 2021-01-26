import 'dart:convert';

import 'package:package_info/package_info.dart';

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
  /// Returns the rUpdate info such as changelog, latest changelog and latest version name
  Future<ServerUpdater> _returnServerInfo() async {
    var link = 'https://engrish.web.app/update.json';
    var res = await http
        .get(Uri.encodeFull(link), headers: {'Accept': 'application/json'});
    var parsed = jsonDecode(res.body).cast<Map<String, dynamic>>();
    return parsed
        .map<ServerUpdater>((json) => ServerUpdater.fromJson(json))
        .toList();
  }

  Future _askForUpdate() async {
    // TODO: Implement update process.
    // The update process should be composed of notifying the user that an update is available,
    // downloading the update into the downloads folder using flutter_downloader
    // (consider requesting storage permision with permission_handler),
    // request app install permission and install using install_plugin.
  }

  Future checkForUpdates() async {
    var info = await _returnServerInfo();
    var packageInfo = await PackageInfo.fromPlatform();
    var appVersionCode = int.parse(packageInfo.buildNumber);
    if (info.version < appVersionCode) {
      await _askForUpdate();
    } else {
      return;
    }
  }
}
