import 'package:engrish/Models/CPS.dart';
import 'package:flutter/cupertino.dart';

class Tests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CPS(
      child: Container(
        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('Teste'),
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
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Text(
                          'Porțiunea aceasta nu e finalizată! Revino după următoarele actualizări!',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
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
