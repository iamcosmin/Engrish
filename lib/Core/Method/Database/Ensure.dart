import 'package:engrish/Core/Core.dart';
// Awaiting null safe version of the following plugin(s).
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_core/firebase_core.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

class Ensure extends Core {
  /// Getting all necesary info for the first time in bulk, then refreshing only on pull
  /// to refresh
  Future infoIsInit() async {
    SharedPreferences? pfs = await SharedPreferences.getInstance();
    // bool? isTestsCached = pfs.getBool('isTestsCached')?;
    bool? isGradesCached = pfs.getBool('isGradesCached')?;
    bool? isNameCached = pfs.getBool('isNameCached')?;
    // bool? isFreeCached = pfs.getBool('isFreeCached')?;
    // bool? isNextTestCached = pfs.getBool('isNextTestCached')?;
    var exceptions = <String>[];

    bool? isCachedDataCorrupted = isNameCached == null ||
        isGradesCached == null /* ||
        isTestsCached == null ||
        isNextTestCached == null ||
        isFreeCached == null */ ;

    if (isCachedDataCorrupted) {
      isNameCached ?? exceptions.add('isNameCached');
      isGradesCached ?? exceptions.add('isGradesCached');
      await Core.db.exceptOnNonCached(exceptions: exceptions);
    } else {
      // 1. Reassign the variables to non-null ones (this will be changed when shared-preferences
      // will be null safe)
      bool newNullSafeIsNameCached = pfs.getBool('isNameCached');
      bool newNullSafeIsGradesCached = pfs.getBool('isGradesCached');
      if (!newNullSafeIsNameCached) {
      var name = await (Core.db.get.onlineName() as Future<String>);
      await pfs.setString('name', name);
    } else if (!newNullSafeIsGradesCached) {
      var intGrades = await (Core.db.get.onlineGrades() as Future<List<dynamic>>);
      var strGrades = intGrades.map((e) => e.toString()).toList();
      await pfs.setStringList('grades', strGrades);
    }

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
    // Awaiting null safe version of the following plugin(s).
    // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    // var analytics = FirebaseAnalytics();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: CupertinoColors.black));
    await Core.login.setTokens();
    var isAuth = await Core.login.isAuth();
    return isAuth;
  }
}
