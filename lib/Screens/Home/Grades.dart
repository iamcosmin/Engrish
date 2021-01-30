import 'package:engrish/Core/Core.dart';
import 'package:engrish/Models/CPS.dart';
import 'package:flutter/cupertino.dart';

class Grades extends StatefulWidget {
  @override
  _GradesState createState() => _GradesState();
}

class _GradesState extends State<Grades> {
  List grades = [];
  String gradesString = '';
  String lastGrade = '';

  Future asyncStuff() async {
    List tempGrades = await Core.db.get.grades();
    setState(() {
      grades = tempGrades;
      lastGrade = tempGrades.last.toString();
      gradesString = tempGrades.map((i) => i.toString()).join(', ');
    });
  }

  Future triggerRefresh() async {
    var newGrades = await Core.db.refreshGrades();
    setState(() {
      grades = newGrades;
      lastGrade = newGrades.last.toString();
      gradesString = newGrades.map((i) => i.toString()).join(', ');
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
            CupertinoSliverNavigationBar(
              largeTitle: Text('Note'),
            ),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 10),
                          child: Text(
                            'Ultima ta notă:',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 20),
                          child: Text(
                            lastGrade,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 30),
                          child: Text(
                            'Restul notelor:',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 20),
                          child: Text(
                            gradesString,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
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
