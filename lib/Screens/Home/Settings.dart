import 'package:engrish/Core/Core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Models/CPS.dart';
import '../Login/OOBE.dart';

class Settings extends UIKit {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return CPS(
      child: Container(
        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text(
                'Setari',
              ),
              leading: Container(),
            ),
            CupertinoSliverRefreshControl(
              onRefresh: () async {
                return Future.delayed(Duration(seconds: 3));
              },
            ),
            SliverSafeArea(
              top: false,
              // This is just a big list of all the items in the settings.
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Container(),
                    CupertinoButton(
                      onPressed: () => Core.login
                          .resetSession(ctx: context, tEntryScreen: OOBE()),
                      child: Text('Sign out'),
                    ),
                    CupertinoButton(
                      onPressed: () => Core.misc.alert(ctx: context),
                      child: Text('Sign out'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
