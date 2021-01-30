import 'dart:convert';

import 'package:flutter/cupertino.dart';
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

// We need to have a separate update Widget in Settings.
// We will use isUpdateAvailable() for letting the widgets know if update is available.
// the app and checkForUpdates() when we launch the section in Settings.

// Another way of showing updates will be a notification on the home screen instead of a dialog popup
//
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

  // Future _downloadUpdate() async {
  //   // TODO: Implement update process.
  //   // The update process should be composed of notifying the user that an update is available,
  //   // downloading the update into the downloads folder using flutter_downloader
  //   // (consider requesting storage permision with permission_handler),
  //   // request app install permission and install using install_plugin.
  // }

  Future _askUserForUpdate(
      {@required BuildContext ctx,
      @required String vName,
      @required int vCode,
      @required String vChangelog,
      @required bool isMandatory}) async {
    await showCupertinoDialog(
        context: ctx,
        builder: (ctx) => CupertinoAlertDialog(
              title: Text('Actualizare disponibilă!'),
              content: Text(
                  'Versiunea $vName (${vCode.toString}) este disponibilă.'),
            ));
  }

  /// Handles update checking in Settings.
  Future checkForUpdates({@required BuildContext ctx}) async {
    var info = await _returnServerInfo();
    var updateRequest = await isUpdateAvailable();

    if (updateRequest) {
      await _askUserForUpdate(
          ctx: ctx,
          isMandatory: info.mandatory,
          vChangelog: info.changelog,
          vCode: info.version,
          vName: info.versionName);
    }
  }

  /// Checks if updates are available.
  /// Returns true if an update is available and false if an update is not available.
  Future<bool> isUpdateAvailable() async {
    var info = await _returnServerInfo();
    var packageInfo = await PackageInfo.fromPlatform();
    var appVersionCode = int.parse(packageInfo.buildNumber);
    if (info.version > appVersionCode) {
      return true;
    } else {
      return false;
    }
  }

  /// Requests info about an update from the server. Returns an ServerUpdater object.
  Future<ServerUpdater> requestSuplimentaryUpdateInfo() async {
    var info = await _returnServerInfo();
    return info;
  }
}
