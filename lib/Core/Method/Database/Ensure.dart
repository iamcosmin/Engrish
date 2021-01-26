import 'package:engrish/Core/Core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ensure extends Core {
  /// Getting all necesary info for the first time in bulk, then refreshing only on pull
  /// to refresh
  Future infoIsInit() async {
    var pfs = await SharedPreferences.getInstance();
    var isTestsCached = pfs.getBool('isTestsCached');
    var isGradesCached = pfs.getBool('isGradesCached');
    var isNameCached = pfs.getBool('isNameCached');
    var isFreeCached = pfs.getBool('isFreeCached');
    var isNextTestCached = pfs.getBool('isNextTestCached');
    var exceptions = <String>[];

    var isCachedDataCorrupted = isNameCached == null ||
        isGradesCached == null ||
        isTestsCached == null ||
        isNextTestCached == null ||
        isFreeCached == null;

    if (isCachedDataCorrupted) {
      isNameCached ?? exceptions.add('isNameCached');
      isGradesCached ?? exceptions.add('isGradesCached');
      await Core.db.exceptOnNonCached(exceptions: exceptions);
    }
    if (!isNameCached) {
      var name = await Core.db.get.onlineName();
      await pfs.setString('name', name);
    } else if (!isGradesCached) {
      var intGrades = await Core.db.get.onlineGrades();
      var strGrades = intGrades.map((e) => e.toString()).toList();
      await pfs.setStringList('grades', strGrades);
    }
  }

  /// Place in OOBE. Will update every bool to false to show info is not cached
  /// and will empty the info.
  Future cleanStart() async {
    var pfs = await SharedPreferences.getInstance();
    await pfs.setBool('isTestsCached', false);
    await pfs.setBool('isGradesCached', false);
    await pfs.setBool('isNameCached', false);
    await pfs.remove('grades');
    await pfs.remove('name');
  }

  /// This will ensure all plugins wil run at runtime without flooding the actual main function.
  Future<bool> ensurePluginsRuntime() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    // ignore: unused_local_variable
    var analytics = FirebaseAnalytics();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: CupertinoColors.black));
    await Core.login.setTokens();
    var isAuth = await Core.login.isAuth();
    return isAuth;
  }
}
