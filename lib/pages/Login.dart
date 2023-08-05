import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartania/globals/Acolors.dart';
import 'package:dartania/pages/FogotPass.dart';
import 'package:dartania/pages/Register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../widgets/textWidget.dart';
import 'Home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var h, w;

  TextEditingController user = TextEditingController();
  bool userError = false;
  String userErrorMsg = "";

  TextEditingController pass = TextEditingController();
  bool passError = false;
  String passErrorMsg = "";

  bool hidePass = true;

  bool _click = false;


  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: LoginGradient,
                begin: Alignment.bottomLeft,
                end: Alignment.topRight)),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 90, left: 140),
                  child: textWidget(
                      msg: "Login",
                      txtColor: kGreen,
                      txtFontWeight: FontWeight.bold,
                      txtFontSize: h * 0.05)),
              Container(
                height: h * 0.60,
                width: w,
                margin: EdgeInsets.only(top: 350),
                decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Column(
                  children: [

                    //User textfield
                    SizedBox(
                      height: h * 0.09,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                          ),
                          child: textWidget(
                              msg: "User",
                              txtColor: kGreen,
                              txtFontWeight: FontWeight.w600,
                              txtFontSize: h * 0.02),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      child: Container(
                        height: h * 0.065,
                        width: w * 0.87,
                        padding: EdgeInsets.only(left: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: textFieldGrad,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                  color: kBlack,
                                  blurRadius: 15,
                                  spreadRadius: -13,
                                  offset: Offset(2, 4))
                            ]),
                        child: TextField(
                          controller: user,
                          canRequestFocus: true,
                          keyboardType: TextInputType.emailAddress,
                          onTapOutside: (event) => FocusScope.of(context).unfocus(),
                          style: GoogleFonts.notoSans(
                              textStyle: TextStyle(
                            color: kGreen,
                            fontSize: h * 0.017,
                            fontWeight: FontWeight.w500,
                          )),
                          cursorColor: kGreen,
                          onChanged: (value) {
                            if (userError) {
                              if (value.isNotEmpty) {
                                userError = false;
                                setState(() {});
                              }
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Email or Mobile",
                            hintStyle: GoogleFonts.notoSans(
                                textStyle: TextStyle(
                              color: kGreenLight,
                              fontSize: h * 0.017,
                              fontWeight: FontWeight.w500,
                            )),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: textWidget(
                              msg: userError ? userErrorMsg : "",
                              txtColor: kError,
                              txtFontWeight: FontWeight.w500,
                              txtFontSize: h * 0.016),
                        )
                      ],
                    ),

                    //password textfield
                    SizedBox(
                      height: h * 0.015,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                          ),
                          child: textWidget(
                              msg: "Password",
                              txtColor: kGreen,
                              txtFontWeight: FontWeight.w600,
                              txtFontSize: h * 0.02),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      child: Container(
                        height: h * 0.065,
                        width: w * 0.87,
                        padding: EdgeInsets.only(left: 20, top: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: textFieldGrad,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                  color: kBlack,
                                  blurRadius: 15,
                                  spreadRadius: -13,
                                  offset: Offset(2, 4))
                            ]),
                        child: TextField(
                          controller: pass,
                          canRequestFocus: true,
                          keyboardType: TextInputType.text,
                          onTapOutside: (event) => FocusScope.of(context).unfocus(),
                          style: GoogleFonts.notoSans(
                              textStyle: TextStyle(
                            color: kGreen,
                            fontSize: h * 0.017,
                            fontWeight: FontWeight.w500,
                          )),
                          cursorColor: kGreen,
                          onChanged: (value) {
                            if (passError) {
                              if (value.isNotEmpty) {
                                passError = false;
                                setState(() {});
                              }
                            }
                          },
                          obscureText: hidePass,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter your Password",
                            hintStyle: GoogleFonts.notoSans(
                                textStyle: TextStyle(
                              color: kGreenLight,
                              fontSize: h * 0.017,
                              fontWeight: FontWeight.w500,
                            )),
                            suffixIcon: Container(
                              height: h * 0.04,
                              width: h * 0.04,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(bottom: 5),
                              child: IconButton(
                                  onPressed: () {
                                    hidePass = !hidePass;
                                    setState(() {});
                                  },
                                  icon: AnimatedCrossFade(
                                      firstChild: Icon(
                                        Icons.visibility_outlined,
                                        color: kGreen,
                                      ),
                                      secondChild: Icon(
                                        Icons.visibility_off_outlined,
                                        color: kGreen,
                                      ),
                                      crossFadeState: hidePass
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                      duration: Duration(milliseconds: 300))),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: textWidget(
                              msg: passError ? passErrorMsg : "",
                              txtColor: kError,
                              txtFontWeight: FontWeight.w500,
                              txtFontSize: h * 0.016),
                        )
                      ],
                    ),

                    // forgot password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:
                          EdgeInsets.only(left: 40),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, FadeRoute1(Register()));
                            },
                            child: Text(
                              "Don't have an Account ?",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: kGreen,
                                      fontWeight: FontWeight.bold,
                                      fontSize: h * 0.016,
                                      )),
                            ),
                          ),
                        ),

                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, FadeRoute1(ForgotPass()));
                            },
                            child: Text(
                              "Forgot Password ?",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: kError,
                                      fontWeight: FontWeight.bold,
                                      fontSize: h * 0.016,
                                      decoration: TextDecoration.underline)),
                            ),
                          ),
                        )
                      ],
                    ),

                    // Submit Button
                    SizedBox(
                      height: h * 0.025,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            _click = true;

                            String USER = user.text.trim();
                            String PASSWORD = pass.text.trim();

                            if (USER.isEmpty) {
                              userError = true;
                              _click = false;
                              userErrorMsg = "Please Enter your Email or mobile !";
                              setState(() {});
                            } else if (PASSWORD.isEmpty) {
                              passError = true;
                              _click = false;
                              passErrorMsg = "Please Enter your Password !";
                              setState(() {});
                            } else {
                              Future.delayed(Duration(seconds: 1), () {
                                Navigator.pushReplacement(
                                    context,
                                    FadeRoute1(Home()));
                              });
                            }

                            setState(() {});
                          },
                          child: Container(
                              height: h * 0.06,
                              width: w * 0.4,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: LoginGradient,
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight),
                                  boxShadow: [
                                    BoxShadow(
                                        color: kBlack,
                                        spreadRadius: -12,
                                        blurRadius: 20,
                                        offset: Offset(2, 4)),
                                  ],
                                  borderRadius: BorderRadius.circular(15)),
                              child: _click == true
                                  ? Container(
                                      height: h * 0.02,
                                      width: h * 0.02,
                                      child: CircularProgressIndicator(
                                        color: kGreen,
                                        strokeWidth: 3,
                                      ))
                                  : textWidget(
                                      msg: "Login",
                                      txtColor: kGreen,
                                      txtFontWeight: FontWeight.bold,
                                      txtFontSize: h * 0.02)),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: h * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textWidget(
                            msg: "OR",
                            txtColor: kGrey,
                            txtFontWeight: FontWeight.bold,
                            txtFontSize: h * 0.017)
                      ],
                    ),

                    // Social Login
                    SizedBox(
                      height: h * 0.003,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                width: w * 0.9,
                                behavior: SnackBarBehavior.floating,
                                content: Center(
                                  child: Text(
                                    'This functionality will be adding soon ...',
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            color: kWhite,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                backgroundColor: kError,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Container(
                            height: h * 0.055,
                            width: h * 0.055,
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: kWhite,
                              boxShadow: [
                                BoxShadow(
                                    color: kBlack,
                                    spreadRadius: -12,
                                    blurRadius: 20,
                                    offset: Offset(2, 4)),
                              ],
                            ),
                            child: Image.asset(
                              "images/google.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                width: w * 0.9,
                                behavior: SnackBarBehavior.floating,
                                content: Center(
                                  child: Text(
                                    'This functionality will be adding soon ...',
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            color: kWhite,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                backgroundColor: kError,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Container(
                            height: h * 0.055,
                            width: h * 0.055,
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: kWhite,
                              boxShadow: [
                                BoxShadow(
                                    color: kBlack,
                                    spreadRadius: -12,
                                    blurRadius: 20,
                                    offset: Offset(2, 4)),
                              ],
                            ),
                            child: Image.asset(
                              "images/facebook.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                width: w * 0.9,
                                behavior: SnackBarBehavior.floating,
                                content: Center(
                                  child: Text(
                                    'This functionality will be adding soon ...',
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            color: kWhite,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                backgroundColor: kError,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Container(
                            height: h * 0.055,
                            width: h * 0.055,
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: kWhite,
                              boxShadow: [
                                BoxShadow(
                                    color: kBlack,
                                    spreadRadius: -12,
                                    blurRadius: 20,
                                    offset: Offset(2, 4)),
                              ],
                            ),
                            child: Image.asset(
                              "images/instagram.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                top: h * 0.2,
                left: w * 0.223,
                child: Container(
                  height: h * 0.2,
                  width: w * 0.55,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Lottie.network(
                      "https://assets5.lottiefiles.com/packages/lf20_2TUV98WaqI.json",
                      frameRate: FrameRate(120),
                      fit: BoxFit.cover),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
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