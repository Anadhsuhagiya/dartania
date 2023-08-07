import 'package:dartania/globals/Acolors.dart';
import 'package:dartania/pages/x01/x01Settings.dart';
import 'package:dartania/widgets/textWidget.dart';
import 'package:flutter/material.dart';

import '../globals/pagetransition.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  var h , w;
  
  @override
  Widget build(BuildContext context) {
    
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    
    return SafeArea(child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/da.png",height: h * 0.15,)
            ],
          ),

          SizedBox(height: h * 0.035,),
          InkWell(
            onTap: () {

              Navigator.push(context, FadeRoute1(x01()));

            },
            child: Container(
              height: h * 0.07,
              width: w * 0.7,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kGreen,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: kBlack,
                    offset: Offset(2, 5),
                    blurRadius: 20,
                    spreadRadius: -13
                  )
                ],
              ),
              child: textWidget(msg: "X01", txtColor: kWhite, txtFontWeight: FontWeight.bold, txtFontSize: h * 0.022),
            ),
          ),

          SizedBox(height: h * 0.02,),
          Container(
            height: h * 0.07,
            width: w * 0.7,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: kGreen,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                    color: kBlack,
                    offset: Offset(2, 5),
                    blurRadius: 20,
                    spreadRadius: -13
                )
              ],
            ),
            child: textWidget(msg: "Cricket", txtColor: kWhite, txtFontWeight: FontWeight.bold, txtFontSize: h * 0.022),
          ),

          SizedBox(height: h * 0.02,),
          Container(
            height: h * 0.07,
            width: w * 0.7,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: kGreen,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                    color: kBlack,
                    offset: Offset(2, 5),
                    blurRadius: 20,
                    spreadRadius: -13
                )
              ],
            ),
            child: textWidget(msg: "Practice", txtColor: kWhite, txtFontWeight: FontWeight.bold, txtFontSize: h * 0.022),
          ),

        ],
      ),
    ));
  }
}





