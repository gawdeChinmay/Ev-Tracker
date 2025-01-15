import 'package:flutter/material.dart';
import 'package:sa4_migration_kit/multi_tween/multi_tween.dart';
import 'package:simple_animations/movie_tween/movie_tween.dart';
import 'package:simple_animations/simple_animations.dart';

class Fadeanimation extends StatelessWidget {
  final double delay;
  final Widget child;

  Fadeanimation(this.child, this.delay);

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween(
        'opacity',
        Tween(begin: 0.0, end: 1.0), // Fade out
        duration: const Duration(milliseconds: 500),
      ).thenTween(
        'x',
        Tween(begin: 120.0, end: 0.0), // Move horizontally to the right
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn, // Use an ease-in curve for smooth exit
      );

    return PlayAnimationBuilder<Movie>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, value, child) => Opacity(
        opacity: value.get("opacity"),
        child: Transform.translate(
            offset: Offset(value.get("x"), 0), child: child),
      ),
    );
  }
}
