import 'package:engrish/Core/Core.dart';
import 'package:engrish/Models/TButton.dart';
import 'package:engrish/Screens/Home/Main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Models/CPS.dart';

// ignore: must_be_immutable
class Logon extends StatelessWidget {
  String _token;

  @override
  Widget build(BuildContext context) {
    return CPS(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.black,
        previousPageTitle: 'Înapoi',
        trailing: TButton(
          onTap: () async {
            await Core.login.chktkn(token: _token, ctx: context, home: Main());
          },
          loader: false,
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.lock_fill,
                    size: 75,
                    color: CupertinoColors.systemBlue,
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Center(
                    child: Text(
                      'Introdu tokenul',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 30)),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: CupertinoTextField(
                        prefix: Padding(
                            padding:
                                EdgeInsets.only(left: 7, right: 5, bottom: 3),
                            child: Icon(CupertinoIcons.mail_solid)),
                        decoration: BoxDecoration(
                          color: CupertinoColors.darkBackgroundGray,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        placeholder: 'Token',
                        onChanged: (value) => _token = value.trim(),
                        style: TextStyle(
                          fontSize: 17,
                        )),
                  ),
                  Padding(padding: EdgeInsets.only(top: 60)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
