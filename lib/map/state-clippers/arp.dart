import 'package:flutter/material.dart';

class ARPClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 411;
    final double _yScaling = size.height / 826;
    path.lineTo(2.50858 * _xScaling, 39.9781 * _yScaling);

    path.cubicTo(
      3.50858 * _xScaling,
      49.9781 * _yScaling,
      5.85258 * _xScaling,
      39.7796 * _yScaling,
      5.85258 * _xScaling,
      59.7796 * _yScaling,
    );

    path.cubicTo(
      8.85258 * _xScaling,
      39.7796 * _yScaling,
      2.71393 * _xScaling,
      38.9744 * _yScaling,
      2.71393 * _xScaling,
      38.9744 * _yScaling,
    );
    path.cubicTo(
      2.71393 * _xScaling,
      38.9744 * _yScaling,
      4.74825 * _xScaling,
      37.9959 * _yScaling,
      4.74825 * _xScaling,
      37.9959 * _yScaling,
    );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
