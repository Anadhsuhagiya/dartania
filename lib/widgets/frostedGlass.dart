import 'dart:ui';

import 'package:flutter/cupertino.dart';

class FrostedGlass extends StatelessWidget {
  const FrostedGlass({super.key, required this.widget});


  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),child: widget,),
    );
  }
}
