import 'package:dartania/globals/haptic_feedbacks.dart';
import 'package:dartania/pages/Login.dart';
import 'package:dartania/widgets/textWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../globals/Acolors.dart';
import '../pages/x01/x01Settings.dart';

class InfoCard extends StatefulWidget {
  String PlayerStatus;

  InfoCard(this.PlayerStatus);

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  bool isTapped = true;
  bool isExpand = false;

  var h, w;

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: kWhite.withOpacity(0.6),
      content: Container(
        height: h * 0.17,
        width: w * 0.7,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/win.png',width: w * 0.09,),
                SizedBox(width: w * 0.03,),
                textWidget(msg: "${widget.PlayerStatus}", txtColor: kBlack, txtFontWeight: FontWeight.bold, txtFontSize: h * 0.03)
              ],
            ),

            SizedBox(height: h * 0.03,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textWidget(msg: "Winner", txtColor: kBlack, txtFontWeight: FontWeight.w600, txtFontSize: h * 0.018)
              ],
            ),

            SizedBox(height: h * 0.02,),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                lightImpact();
                Navigator.pushReplacement(context, FadeRoute1(x01()));
              },
              child: Container(
                height: h * 0.05,
                width: w * 0.3,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: kGreen,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                          color: kBlack,
                          spreadRadius: -17,
                          blurRadius: 20,
                          offset: Offset(2, 4)
                      )
                    ]
                ),
                child: textWidget(msg: "OK", txtColor: kWhite, txtFontWeight: FontWeight.bold, txtFontSize: h * 0.02),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
