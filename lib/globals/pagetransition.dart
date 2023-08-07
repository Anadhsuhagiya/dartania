import 'package:flutter/cupertino.dart';

class SlideTransition1 extends PageRouteBuilder {
  final Widget page;

  SlideTransition1(this.page)
      : super(
      pageBuilder: (context, animation, anotherAnimation) => page,
      transitionDuration: Duration(milliseconds: 1000),
      reverseTransitionDuration: Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, anotherAnimation, child) {
        animation = CurvedAnimation(
            curve: Curves.fastLinearToSlowEaseIn,
            parent: animation,
            reverseCurve: Curves.fastOutSlowIn);
        return SlideTransition(
          position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
              .animate(animation),
          child: page,
        );
      });
}

class ScaleTransition2 extends PageRouteBuilder {
  final Widget page;

  ScaleTransition2(this.page)
      : super(
    pageBuilder: (context, animation, anotherAnimation) => page,
    transitionDuration: Duration(milliseconds: 1000),
    reverseTransitionDuration: Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, anotherAnimation, child) {
      animation = CurvedAnimation(
          curve: Curves.fastLinearToSlowEaseIn,
          parent: animation,
          reverseCurve: Curves.fastOutSlowIn);
      return ScaleTransition(
        alignment: Alignment.topCenter,
        scale: animation,
        child: child,
      );
    },
  );
}

class ScaleTransition4 extends PageRouteBuilder {
  final Widget page;

  ScaleTransition4(this.page)
      : super(
    pageBuilder: (context, animation, anotherAnimation) => page,
    transitionDuration: Duration(milliseconds: 1000),
    reverseTransitionDuration: Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, anotherAnimation, child) {
      animation = CurvedAnimation(
          curve: Curves.fastLinearToSlowEaseIn,
          parent: animation,
          reverseCurve: Curves.fastOutSlowIn);
      return ScaleTransition(
        alignment: Alignment.bottomRight,
        scale: animation,
        child: child,
      );
    },
  );
}

class FadeRoute1 extends PageRouteBuilder {
  final Widget page;

  FadeRoute1(this.page)
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: page,
        ),
  );
}

