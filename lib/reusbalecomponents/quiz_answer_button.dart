import 'package:flutter/material.dart';

Route<Object?> customroute(Widget screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end).animate(animation);
      return SlideTransition(
        position: tween,
        child: child,
      );
    },
  );
}
