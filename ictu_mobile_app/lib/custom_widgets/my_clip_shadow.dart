import 'package:flutter/material.dart';

class _ClipShadowPainter extends CustomPainter {

  _ClipShadowPainter({required this.clipper, required this.clipShadow});
  /// If non-null, determines which clip to use.
  final CustomClipper<Path> clipper;

  /// A list of shadows cast by this box behind the box.
  final List<BoxShadow> clipShadow;

  @override
  void paint(Canvas canvas, Size size) {
    for (var shadow in clipShadow) {
      var paint = shadow.toPaint();
      var spreadSize = Size(size.width + shadow.spreadRadius * 2,
          size.height + shadow.spreadRadius * 2);
      var clipPath = clipper.getClip(spreadSize).shift(Offset(
          shadow.offset.dx - shadow.spreadRadius,
          shadow.offset.dy - shadow.spreadRadius));
      canvas.drawPath(clipPath, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class MyClipShadow extends StatelessWidget {

  const MyClipShadow(
      {super.key, this.boxShadow, required this.clipper, required this.child});
  /// A list of shadows cast by this box behind the box.
  final List<BoxShadow>? boxShadow;

  /// If non-null, determines which clip to use.
  final CustomClipper<Path>? clipper;

  /// The [Widget] below this widget in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return clipper == null
        ? SizedBox(
            child: child,
          )
        : CustomPaint(
            painter: _ClipShadowPainter(
                clipShadow: boxShadow ??
                    [
                      const BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3.0,
                        spreadRadius: 3.0,
                        offset: Offset(0.0, 2.0),
                      ),
                    ],
                clipper: clipper!),
            child: ClipPath(
              clipper: clipper,
              child: child,
            ),
          );
  }
}
