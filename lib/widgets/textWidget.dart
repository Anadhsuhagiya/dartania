import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class textWidget extends StatelessWidget {
  const textWidget({Key? key, required this.msg , required this.txtColor , required this.txtFontWeight , required this.txtFontSize}) : super(key: key);

  final String msg;
  final Color txtColor;
  final FontWeight txtFontWeight;
  final double txtFontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      msg,
      style: GoogleFonts.montserrat(textStyle: TextStyle(color: txtColor , fontWeight: txtFontWeight , fontSize: txtFontSize)),
    );
  }
}
