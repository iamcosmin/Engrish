import 'package:engrish/Core/Core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/CPS.dart';
import 'Login.dart';

class OOBE extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<OOBE> {
  Future asyncMethod() async {
    await Core.db.ensure.cleanStart();
  }

  @override
  void initState() {
    asyncMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CPS(
      child: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.gift_fill,
                    size: 75,
                    color: Colors.redAccent,
                  ),
                  Center(
                    child: Text(
                      'Bun venit la Engrish!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: CupertinoButton.filled(
                        borderRadius: BorderRadius.circular(15),
                        onPressed: () => {
                          Core.navigate.to(
                            ctx: context,
                            route: Logon(),
                          ),
                        },
                        child: Text(
                          'Să începem!',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: CupertinoColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
