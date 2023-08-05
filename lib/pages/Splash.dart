import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:dartania/globals/Acolors.dart';
import 'package:dartania/pages/Home.dart';
import 'package:dartania/pages/Login.dart';
import 'package:dartania/pages/x01/x01Game.dart';
import 'package:dartania/pages/x01/x01Settings.dart';
import 'package:dartania/widgets/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> with SingleTickerProviderStateMixin {
  var h, w;

  late AnimationController _controller;

  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ));
        }
        setState(() {});
      });

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();


  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kBlack,
      body: Container(
        height: h,
        width: w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/bg.jpg"),
                fit: BoxFit.cover,
                opacity: 0.1)),
        child: FadeScaleTransition(
          animation: _animation,
          child: Container(
              height: h * 0.3,
              width: w * 0.8,
              child: Image.asset(
                "images/da.png",
                fit: BoxFit.cover,
              )),
        ),
      ),
    );
  }
}
