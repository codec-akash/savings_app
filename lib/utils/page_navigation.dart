import 'dart:math';

import 'package:flutter/material.dart';

class PageRouteNavigation extends PageRouteBuilder {
  final Widget enterPage;
  final Widget exitPage;

  PageRouteNavigation({required this.enterPage, required this.exitPage})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              enterPage,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              Stack(
            children: [
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.0),
                  end: const Offset(-1.0, 0.0),
                ).animate(animation),
                child: exitPage,
              ),
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: enterPage,
              )
            ],
          ),
        );
}
