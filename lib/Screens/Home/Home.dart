import 'package:engrish/Core/Core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../Models/CPS.dart';

class Home extends UIKit {
  @override
  HomeScreen createState() => HomeScreen();
}

class HomeScreen extends State<Home> {
  String name = '';

  Future asyncStuff() async {
    var tempName = await Core.db.get.name();
    setState(() {
      name = tempName;
    });
  }

  Future triggerRefresh() async {
    var newName = await Core.db.refreshName();
    setState(() {
      name = newName;
    });
  }

  @override
  void initState() {
    asyncStuff();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CPS(
      child: Container(
        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(largeTitle: Text('Acasă')),
            CupertinoSliverRefreshControl(
              onRefresh: () async {
                return triggerRefresh();
              },
            ),
            SliverSafeArea(
              top: false,
              // This is just a big list of all the items in the settings.
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 50.0, top: 30),
                      child: Text(
                        'Bună, $name!',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: CupertinoColors.darkBackgroundGray,
                            ),
                            alignment: Alignment.center,
                            height: 105,
                            width: 330,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10, left: 25),
                                  child: Text(
                                    'Învoit până la data de',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 2, left: 20),
                                  child: Text(
                                    '1 aprilie 2021',
                                    style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 2, left: 25),
                                  child: Text(
                                    'Nu uita să îți recuperezi lecțiile!',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: CupertinoColors.inactiveGray,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: CupertinoColors.darkBackgroundGray,
                            ),
                            alignment: Alignment.center,
                            height: 105,
                            width: 155,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10, left: 25),
                                  child: Text(
                                    'Medie',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 2, left: 20),
                                  child: Text(
                                    '7,25',
                                    style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 2, left: 25),
                                  child: Text(
                                    'Ultima notă: 8',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: CupertinoColors.inactiveGray,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 20)),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: CupertinoColors.darkBackgroundGray,
                            ),
                            alignment: Alignment.center,
                            height: 105,
                            width: 155,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10, left: 25),
                                  child: Text(
                                    'Medie',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 2, left: 20),
                                  child: Text(
                                    '7,25',
                                    style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 2, left: 25),
                                  child: Text(
                                    'Ultima notă: 8',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: CupertinoColors.inactiveGray,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: CupertinoColors.darkBackgroundGray,
                            ),
                            alignment: Alignment.center,
                            height: 105,
                            width: 155,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 10, left: 25),
                                  child: Text(
                                    'Medie',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 2, left: 20),
                                  child: Text(
                                    '7,25',
                                    style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 2, left: 25),
                                  child: Text(
                                    'Ultima notă: 8',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: CupertinoColors.inactiveGray,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 20)),
                        ],
                      ),
                    )
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
