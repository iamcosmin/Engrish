import 'package:engrish/Core/Core.dart';
// Awaiting null safe version of the following plugin(s).
// import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
    SharedPreferences pfs = await SharedPreferences.getInstance();
    bool? isNameCached = pfs.getBool('isNameCached')?;

    if (isNameCached == false || isNameCached == null) {
      
      await pfs.setBool('isNameCached', true);
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
    // var analytics = FirebaseAnalytics();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: CupertinoColors.black));
    await Core.login.setTokens();
    var isAuth = await Core.login.isAuth();
    return isAuth;
  }
}
