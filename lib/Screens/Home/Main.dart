import 'package:engrish/Core/Core.dart';
import 'package:engrish/Screens/Home/Grades.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';

import 'Home.dart';
import 'Settings/Settings.dart';
import 'Tests.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  Future asyncMethod() async {
    await Core.db.ensure.infoIsInit();
  }

  @override
  void initState() {
    asyncMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.home_24_filled),
            label: 'Acasă',
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.document_24_filled),
            label: 'Teste',
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentIcons.backpack_24_filled),
            label: 'Note',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings_solid),
            label: 'Setări',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            switch (index) {
              case 0:
                return Home();
                break;
              case 1:
                return Tests();
                break;
              case 2:
                return Grades();
                break;
              case 3:
                return Settings();
                break;
              default:
                return Container();
            }
          },
        );
      },
    );
  }
}
