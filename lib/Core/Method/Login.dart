import 'package:engrish/Core/Core.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends Core {
  /// This function will check if the token the user entered is the same as the
  /// list of predefined tokens. This method is not secure if exposed to a VCS or
  /// if the app is not obfuscated.
  Future chktkn(
      {@required String token,
      @required BuildContext ctx,
      @required Widget home}) async {
    var preferences = await SharedPreferences.getInstance();
    var tokens = preferences.getStringList('tokens');
    if (!tokens.contains(token)) {
      await showCupertinoDialog(
          context: ctx,
          builder: (ctx) => CupertinoAlertDialog(
                title: Text('Atentie!'),
                content: Text('Tokenul e inexistent.'),
                actions: [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () => Navigator.pop(ctx),
                    child: Text('OK'),
                  )
                ],
              ));
    } else {
      await preferences
          .setString('token', token)
          .then((_) => Core.navigate.back(ctx: ctx, repeats: 1))
          .then((_) => Future.delayed(Duration.zero,
              () => Core.navigate.replace(ctx: ctx, route: home)));
    }
  }

  /// This function helps relieve the stress of verifying if the user has entered the token or it
  /// has to.
  Future<bool> isAuth() async {
    var token = await Core.db.get.token();
    var tokens = await Core.db.get.tokenList();

    if (!tokens.contains(token)) {
      return false;
    } else {
      return true;
    }
  }

  /// Sets the base tokens
  Future setTokens() async {
    var tokens = <String>[
      'larisa84940',
      'andreea02847',
      'andreea63518',
      'georgiana93749',
      'testToken'
    ];

    var preferences = await SharedPreferences.getInstance();
    await preferences.setStringList('tokens', tokens);
  }

  /// This resets the session, navigating to the token entry screen.
  Future resetSession({
    @required BuildContext ctx,
    @required Widget tEntryScreen,
  }) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove('token').then(
          (_) => showCupertinoDialog(
            context: ctx,
            builder: (ctx) => CupertinoAlertDialog(
              title: Text('Atentie!'),
              content: Text(
                  'Pentru a finaliza procedura, veti fi dat afara din aplicatie.'),
              actions: [
                CupertinoDialogAction(
                  onPressed: () => throw Exception(
                      'Puteti inchide aplicatia pentru a o reconfigura.'),
                  child: Text('OK'),
                )
              ],
            ),
          ),
        );
  }
}
