import 'package:flutter/cupertino.dart';

class TButton extends StatefulWidget {
  final Function onTap;
  final Duration duration = Duration(milliseconds: 50);
  final double opacity = 0.5;
  final bool loader;

  TButton({
    @required this.onTap,
    @required this.loader,
  });

  @override
  _TButtonState createState() => _TButtonState();
}

class _TButtonState extends State<TButton> {
  bool isDown;

  @override
  void initState() {
    super.initState();
    setState(() => isDown = false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!widget.loader) ...[
          GestureDetector(
            onTapDown: (_) => setState(() => isDown = true),
            onTapUp: (_) => setState(() => isDown = false),
            onTapCancel: () => setState(() => isDown = false),
            onTap: () => widget.onTap,
            child: AnimatedOpacity(
              duration: widget.duration,
              opacity: isDown ? widget.opacity : 1,
              child: Text('Înainte',
                  style: TextStyle(
                    color: CupertinoColors.activeBlue,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.5,
                  )),
            ),
          )
        ] else ...[
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: CupertinoActivityIndicator(),
          ),
        ]
      ],
    );
  }
}
