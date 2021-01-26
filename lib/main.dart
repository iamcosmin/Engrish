import 'package:flutter/cupertino.dart';
import 'package:engrish/Core/Core.dart';

import 'Screens/Home/Main.dart';
import 'Screens/Login/OOBE.dart';

Future main() async {
  var isAuth = await Core.db.ensure.ensurePluginsRuntime();
  runApp(
    CupertinoApp(
      title: 'Engrish',
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(color: CupertinoColors.white),
        ),
      ),
      home: isAuth ? Main() : OOBE(),
    ),
  );
}
