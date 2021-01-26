import 'package:engrish/Core/Core.dart';
import 'package:flutter/cupertino.dart';

class CPS extends UIKit {
  final Widget child;
  final Color backgroundColor;
  final CupertinoNavigationBar navigationBar;
  final bool resizeToAvoidBottomInset;

  CPS(
      {@required this.child,
      this.backgroundColor,
      this.navigationBar,
      this.resizeToAvoidBottomInset});

  @override
  _CPSState createState() => _CPSState();
}

class _CPSState extends State<CPS> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: widget.backgroundColor,
      navigationBar: widget.navigationBar,
      // ignore: avoid_redundant_argument_values
      resizeToAvoidBottomInset: true,
      child: widget.child,
    );
  }
}
