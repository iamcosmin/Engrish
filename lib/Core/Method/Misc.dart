import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

class Misc {
  const Misc();

  Future<String> getString(String key) async {
    var prefs = await SharedPreferences.getInstance();
    //Return String
    var stringValue = prefs.getString(key);
    return stringValue;
  }

  Future<List> getStringList(String key) async {
    var prefs = await SharedPreferences.getInstance();
    //Return String
    List stringValue = prefs.getStringList(key);
    return stringValue;
  }

  void alert({required BuildContext ctx}) {
    showCupertinoDialog(
        context: ctx,
        builder: (ctx) => Stack(
              children: [
                Center(
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                          width: 250.0,
                          height: 200.0,
                          decoration: BoxDecoration(
                              color: CupertinoColors.darkBackgroundGray
                                  .withOpacity(0.5)),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10, left: 10),
                              ),
                              Text(
                                'Alert!',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                              Text('alert desc'),
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            ));
  }
}
