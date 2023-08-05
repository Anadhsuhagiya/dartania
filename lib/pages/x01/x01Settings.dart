import 'dart:ui';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:dartania/globals/Acolors.dart';
import 'package:dartania/globals/vars.dart';
import 'package:dartania/pages/x01/x01Game.dart';
import 'package:dartania/widgets/textWidget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

class x01 extends StatefulWidget {
  const x01({super.key});

  @override
  State<x01> createState() => _x01State();
}

class _x01State extends State<x01> {
  var h, w;

  static Future<void> lightImpact() async {
    await SystemChannels.platform.invokeMethod<void>(
      'HapticFeedback.vibrate',
      'HapticFeedbackType.lightImpact',
    );
  }

  static Future<void> heavyImpact() async {
    await SystemChannels.platform.invokeMethod<void>(
      'HapticFeedback.vibrate',
      'HapticFeedbackType.heavyImpact',
    );
  }

  TextEditingController FirstPlayer = TextEditingController();
  TextEditingController SecondPlayer = TextEditingController();

  final double rotationAngle = 315;

  final List<String> StartScore = [
    '101',
    '201',
    '301',
    '401',
    '501',
    '601',
    '701',
    '801',
    '901',
    '1001',
    '5001',
    '10001',
  ];

  String SelectedScore = "501";

  String Mode = "Best of";
  bool GMode = true;

  String In = "Strait In";
  bool Gin = true;

  TextEditingController leg = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    leg.text = "1";
    initpref();
  }

  initpref() async {
    Model.prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: kBg,
        appBar: PreferredSize(
          child: Container(
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: w,
                  height: h * 0.05,
                  decoration: BoxDecoration(
                      color: kWhite.withOpacity(0.03),
                      boxShadow: [
                        BoxShadow(
                            color: kWhite.withOpacity(0.1),
                            offset: Offset(2, 4),
                            blurRadius: 20,
                            spreadRadius: -17)
                      ]),
                  alignment: Alignment.center,
                  child: textWidget(
                      msg: "X01 Match",
                      txtColor: kWhite,
                      txtFontWeight: FontWeight.bold,
                      txtFontSize: h * 0.025),
                ),
              ),
            ),
          ),
          preferredSize: Size(w, h * 0.05),
        ),


        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: h * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: textWidget(
                                msg: "First Player",
                                txtColor: kFont,
                                txtFontWeight: FontWeight.w600,
                                txtFontSize: h * 0.02),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: BlurryContainer(
                          blur: 5,
                          width: w * 0.40,
                          height: h * 0.06,
                          padding: EdgeInsets.only(top: 1),
                          elevation: 0,
                          color: Colors.white.withOpacity(0.1),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(13)),
                          child: TextField(
                            controller: FirstPlayer,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            onTapOutside: (event) =>
                                FocusScope.of(context).unfocus(),
                            textCapitalization: TextCapitalization.sentences,
                            style: GoogleFonts.notoSans(
                                textStyle: TextStyle(
                              color: kWhite,
                              fontSize: h * 0.017,
                              fontWeight: FontWeight.w500,
                            )),
                            cursorColor: kWhite,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter First Player",
                              hintStyle: GoogleFonts.notoSans(
                                  textStyle: TextStyle(
                                color: kWhite.withOpacity(0.2),
                                fontSize: h * 0.017,
                                fontWeight: FontWeight.w500,
                              )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: textWidget(
                        msg: "VS",
                        txtColor: kFont,
                        txtFontWeight: FontWeight.bold,
                        txtFontSize: h * 0.02),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: textWidget(
                                msg: "Second Player",
                                txtColor: kFont,
                                txtFontWeight: FontWeight.w600,
                                txtFontSize: h * 0.02),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: BlurryContainer(
                          blur: 5,
                          width: w * 0.40,
                          height: h * 0.06,
                          padding: EdgeInsets.only(top: 1),
                          elevation: 0,
                          color: Colors.white.withOpacity(0.1),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(13)),
                          child: TextField(
                            controller: SecondPlayer,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.notoSans(
                                textStyle: TextStyle(
                              color: kWhite,
                              fontSize: h * 0.017,
                              fontWeight: FontWeight.w500,
                            )),
                            cursorColor: kWhite,
                            textCapitalization: TextCapitalization.sentences,
                            onTapOutside: (event) =>
                                FocusScope.of(context).unfocus(),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Second Player",
                              hintStyle: GoogleFonts.notoSans(
                                  textStyle: TextStyle(
                                color: kWhite.withOpacity(0.2),
                                fontSize: h * 0.017,
                                fontWeight: FontWeight.w500,
                              )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: h * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textWidget(
                      msg: "Game Settings",
                      txtColor: kWhite,
                      txtFontWeight: FontWeight.bold,
                      txtFontSize: h * 0.03)
                ],
              ),
              SizedBox(
                height: h * 0.022,
              ),
              Row(
                children: [
                  SizedBox(
                    width: w * 0.06,
                  ),
                  textWidget(
                      msg: "Mode",
                      txtColor: kFont,
                      txtFontWeight: FontWeight.w600,
                      txtFontSize: h * 0.018),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        lightImpact();
                        GMode = true;
                        Mode = "Best Of";
                        print(Mode);
                        setState(() {});
                      },
                      child: Container(
                        height: h * 0.05,
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: GMode ? kWhite : kWhite.withOpacity(0.2),
                            border: Border.all(color: kWhite.withOpacity(0.2), width: 2),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                  color: kBlack,
                                  offset: Offset(2, 4),
                                  blurRadius: 20,
                                  spreadRadius: -17)
                            ]),
                        child: textWidget(
                            msg: "Best Of",
                            txtColor: GMode ? kGreen : kWhite,
                            txtFontWeight: FontWeight.w600,
                            txtFontSize: h * 0.018),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        lightImpact();

                        GMode = false;
                        Mode = "First Of";
                        print(Mode);
                        setState(() {});
                      },
                      child: Container(
                        height: h * 0.05,
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: GMode ? kWhite.withOpacity(0.2) : kWhite,
                            border: Border.all(
                              color: kWhite.withOpacity(0.2),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                  color: kBlack,
                                  offset: Offset(2, 4),
                                  blurRadius: 20,
                                  spreadRadius: -17)
                            ]),
                        child: textWidget(
                            msg: "First Of",
                            txtColor: GMode ? kWhite : kGreen,
                            txtFontWeight: FontWeight.w600,
                            txtFontSize: h * 0.018),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: h * 0.025,
              ),
              Row(
                children: [
                  SizedBox(
                    width: w * 0.06,
                  ),
                  textWidget(
                      msg: "Legs",
                      txtColor: kFont,
                      txtFontWeight: FontWeight.w600,
                      txtFontSize: h * 0.018),
                ],
              ),
              SizedBox(height: h * 0.012,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlurryContainer(
                    blur: 5,
                    width: w * 0.95,
                    height: h * 0.06,
                    padding: EdgeInsets.only(top: 1,left: 20),
                    elevation: 0,
                    color: Colors.white.withOpacity(0.1),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(13)),
                    child: TextField(
                      controller: leg,
                      keyboardType: TextInputType.number,
                      cursorColor: kWhite,
                      onTapOutside: (event) =>
                          FocusScope.of(context).unfocus(),
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: kWhite,
                              fontSize: h * 0.018,
                              fontWeight: FontWeight.w600)),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter numbers of Legs",
                          hintStyle: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: kWhite.withOpacity(0.2),
                                  fontWeight: FontWeight.w500,
                                  fontSize: h * 0.018))),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: h * 0.025,
              ),
              Row(
                children: [
                  SizedBox(
                    width: w * 0.06,
                  ),
                  textWidget(
                      msg: "Start Score",
                      txtColor: kFont,
                      txtFontWeight: FontWeight.w600,
                      txtFontSize: h * 0.018),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      height: h * 0.05,
                      margin: EdgeInsets.all(10),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          items: StartScore.map((e) => DropdownMenuItem(
                                child: textWidget(
                                    msg: e,
                                    txtColor: kWhite,
                                    txtFontWeight: FontWeight.bold,
                                    txtFontSize: h * 0.018),
                                value: e,
                              )).toList(),
                          value: SelectedScore,
                          onChanged: (value) {
                            lightImpact();
                            SelectedScore = value!;
                            setState(() {});
                          },
                          buttonStyleData: ButtonStyleData(
                            height: h * 0.05,
                            width: w * 0.9,
                            padding: EdgeInsets.only(left: 14, right: 14),
                            decoration: BoxDecoration(
                                color: kWhite.withOpacity(0.13),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: kWhite.withOpacity(0.2), width: 2),
                                boxShadow: [
                                  BoxShadow(
                                      color: kBlack,
                                      spreadRadius: -17,
                                      blurRadius: 20,
                                      offset: Offset(2, 4))
                                ]),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Ionicons.chevron_down,
                              color: kWhite,
                            ),
                            iconSize: 16,
                            iconEnabledColor: kWhite,
                            iconDisabledColor: Colors.grey,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: h * 0.3,
                            width: w * 0.95,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: kGrey2Dark,
                            ),
                            offset: const Offset(0, 0),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all(6),
                              thumbVisibility: MaterialStateProperty.all(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 24, right: 14),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: h * 0.025,
              ),
              Row(
                children: [
                  SizedBox(
                    width: w * 0.06,
                  ),
                  textWidget(
                      msg: "Game Starts With ",
                      txtColor: kFont,
                      txtFontWeight: FontWeight.w600,
                      txtFontSize: h * 0.018),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        lightImpact();
                        Gin = true;
                        In = "Strait In";
                        setState(() {});
                      },
                      child: Container(
                        height: h * 0.05,
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Gin ? kWhite : kWhite.withOpacity(0.2),
                            border: Border.all(color: kWhite.withOpacity(0.2), width: 2),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                  color: kBlack,
                                  offset: Offset(2, 4),
                                  blurRadius: 20,
                                  spreadRadius: -17)
                            ]),
                        child: textWidget(
                            msg: "Strait In",
                            txtColor: Gin ? kGreen : kWhite,
                            txtFontWeight: FontWeight.w600,
                            txtFontSize: h * 0.018),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        lightImpact();

                        Gin = false;
                        In = "Double In";
                        setState(() {});
                      },
                      child: Container(
                        height: h * 0.05,
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Gin ? kWhite.withOpacity(0.2) : kWhite,
                            border: Border.all(
                              color: kWhite.withOpacity(0.2),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                  color: kBlack,
                                  offset: Offset(2, 4),
                                  blurRadius: 20,
                                  spreadRadius: -17)
                            ]),
                        child: textWidget(
                            msg: "Double In",
                            txtColor: Gin ? kWhite : kGreen,
                            txtFontWeight: FontWeight.w600,
                            txtFontSize: h * 0.018),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: h * 0.025,
              ),
              Row(
                children: [
                  SizedBox(
                    width: w * 0.06,
                  ),
                  textWidget(
                      msg: "Game Ends With ",
                      txtColor: kFont,
                      txtFontWeight: FontWeight.w600,
                      txtFontSize: h * 0.018),
                ],
              ),
              Container(
                height: h * 0.05,
                alignment: Alignment.center,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                          color: kBlack,
                          offset: Offset(2, 4),
                          blurRadius: 20,
                          spreadRadius: -17)
                    ]),
                child: textWidget(
                    msg: "Double Out",
                    txtColor: kGreen,
                    txtFontWeight: FontWeight.w600,
                    txtFontSize: h * 0.018),
              ),
              SizedBox(
                height: h * 0.035,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textWidget(msg: "Game On", txtColor: kWhite, txtFontWeight: FontWeight.bold, txtFontSize: h * 0.024),
                  SizedBox(width: w * 0.05,),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () async {
                      heavyImpact();

                      String First = FirstPlayer.text.trim();
                      String Second = SecondPlayer.text.trim();
                      String Leg = leg.text.trim();

                      int MatchLeg = int.parse(Leg);

                      if(Mode == "Best of" && MatchLeg.isEven){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            width: w * 0.9,
                            behavior: SnackBarBehavior.floating,
                            content: Center(
                              child: Text(
                                'Legs are must be in odd number when play Best of Matches',
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: kWhite, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            backgroundColor: kError,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                      else{
                        await Model.prefs!.setString('First', First);
                        await Model.prefs!.setString('Second', Second);
                        await Model.prefs!.setString('Mode', Mode);
                        await Model.prefs!.setString('Leg', Leg);
                        await Model.prefs!.setString('Score', SelectedScore);
                        await Model.prefs!.setString('Starts', In);

                        Navigator.pushReplacement(context, SlideTransition1(x01Game()));
                      }


                    },
                    child: Container(
                      height: h * 0.06,
                      width: h * 0.06,
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                          // color: kWhite,
                          // border: Border.all(color: kGreen,width: 3),
                          gradient: LinearGradient(
                              colors: textFieldGrad2,
                              end: Alignment.bottomCenter,
                              begin: Alignment.topCenter),
                          boxShadow: [
                            BoxShadow(
                                color: kBlack,
                                spreadRadius: -17,
                                blurRadius: 20,
                                offset: Offset(2, 4))
                          ]),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationZ(math.pi / 180 * rotationAngle),
                        child: Image.asset("images/darts.png",width: h * 0.04,),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

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

