import 'package:flutter/cupertino.dart';

class Navigation {
  Navigation();

  void to({required BuildContext ctx, required Widget route}) {
    Navigator.push(ctx, CupertinoPageRoute(builder: (ctx) => route));
  }

  void replace({required BuildContext ctx, required Widget route}) {
    Navigator.pushReplacement(ctx, CupertinoPageRoute(builder: (ctx) => route));
  }

  void back({required BuildContext ctx, required int repeats}) {
    for (var i = 0; i < repeats; i++) {
      Navigator.pop(ctx);
    }
  }
}
