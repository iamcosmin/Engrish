import 'package:engrish/Models/Group.dart';
import 'package:engrish/Models/Header.dart';
import 'package:engrish/Models/Item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Models/CPS.dart';

class Settings extends StatefulWidget {
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
                    SettingsGroup(<Widget>[
                      SettingsHeader(),
                    ]),
                    SettingsGroup(<Widget>[
                      SettingsItem(
                        label: 'Aparență',
                        iconAssetLabel:
                            'https://developer.apple.com/design/human-interface-guidelines/ios/images/icons/app_icons/Photos.png',
                        type: SettingsItemType.modal,
                        hasDetails: false,
                        value: MediaQuery.of(context).platformBrightness ==
                                Brightness.light
                            ? 'Light'
                            : 'Dark',
                      ),
                      SettingsItem(
                        label: 'General',
                        iconAssetLabel:
                            'https://developer.apple.com/design/human-interface-guidelines/ios/images/icons/app_icons/Settings.png',
                        type: SettingsItemType.modal,
                        hasDetails: true,
                        // onPress: () =>
                        //   // Navigator.push(
                        //   //     context,
                        //   //     CupertinoPageRoute(
                        //   //         builder: (context) => GeneralPage())),
                      ),
                    ]),
                    SettingsGroup(<Widget>[
                      SettingsItem(
                        label: 'Notificari',
                        iconAssetLabel:
                            'https://developer.apple.com/design/human-interface-guidelines/ios/images/icons/app_icons/Mail.png',
                        type: SettingsItemType.modal,
                        hasDetails: true,
                        // onPress: () => Navigator.push(
                        //     context,
                        //     CupertinoPageRoute(
                        //         builder: (context) => NotificationsPage())),
                      ),
                    ]),
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
