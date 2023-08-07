import 'dart:ui';

import 'package:dartania/globals/Acolors.dart';
import 'package:dartania/globals/ScoreVoice.dart';
import 'package:dartania/globals/haptic_feedbacks.dart';
import 'package:dartania/globals/vars.dart';
import 'package:dartania/widgets/exitCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/frostedGlass.dart';
import '../../widgets/infoCard.dart';
import '../../widgets/textWidget.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class x01Game extends StatefulWidget {
  const x01Game({super.key});

  @override
  State<x01Game> createState() => _x01GameState();
}

class _x01GameState extends State<x01Game> {
  var h, w;

  String FirstPlayer = "";
  String SecondPlayer = "";
  String Mode = "";
  String Leg = "";
  String Score = "";
  String In = "";

  int LastScoreFirst = 0;
  int LastScoreSecond = 0;

  int DartsFirst = 0;
  int DartsSecond = 0;

  double averageFirst = 0.0;
  double averageSecond = 0.0;

  List<double> ListAverageFirst = [];
  List<double> ListAverageSecond = [];

  bool start = true;

  List<int> FirstScoreList = [];
  List<int> SecondScoreList = [];

  List<int> EnterFirstScoreList = [];
  List<int> EnterSecondScoreList = [];

  int LegsFirst = 0;
  int LegsSecond = 0;

  bool status = false;

  stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _speechEnabled = false;

  String SpeekWord = "";

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    ScoreEntering = "";
    EnteringScore = 0;
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      ScoreEntering = result.recognizedWords;

      if (ScoreEntering.isNotEmpty) {
        // Remove non-digit characters (e.g., commas, dots, spaces, etc.)
        String digitsOnly = ScoreEntering.replaceAll(RegExp(r'[^0-9]'), '');
        print("Digits:- $digitsOnly");
        // Convert the remaining string into an integer
        EnteringScore = int.tryParse(digitsOnly)!;
        ScoreEntering = EnteringScore.toString();
      }
    });
  }
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initPref();
    _initSpeech();
  }


  initPref() {
    FirstPlayer = Model.prefs!.getString('First') ?? "";
    SecondPlayer = Model.prefs!.getString('Second') ?? "";
    Mode = Model.prefs!.getString('Mode') ?? "";
    Leg = Model.prefs!.getString('Leg') ?? "";
    Score = Model.prefs!.getString('Score') ?? "";
    In = Model.prefs!.getString('Starts') ?? "";
    status = true;
    First = int.parse(Score);
    Second = int.parse(Score);
    FirstScoreList.add(First!);
    SecondScoreList.add(Second!);
    print("Mode :- $Mode");
    setState(() {});
  }

  int? First;
  int? Second;
  List<int> FirstScore = [];
  List<int> SecondScore = [];

  String ScoreEntering = "";
  int EnteringScore = 0;

  bool chance = true;

  btnClick(String Data) {
    print(Data);

    if (Data == "back") {
      if (ScoreEntering.length >= 1) {
        ScoreEntering = ScoreEntering.substring(0, ScoreEntering.length - 1);
        setState(() {});
        EnteringScore = int.parse(ScoreEntering);
      }
    } else if (Data == "enter") {
      if (Mode == "Best of") {
        if ((int.parse(Leg) / 2) > LegsFirst &&
            (int.parse(Leg) / 2) > LegsSecond) {
          if (chance == true) {
            if (ScoreEntering.isEmpty) {
              chance = !chance;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  width: w * 0.9,
                  behavior: SnackBarBehavior.floating,
                  content: Center(
                    child: Text(
                      'Enter Score',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: kWhite, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  backgroundColor: kError,
                  duration: Duration(seconds: 2),
                ),
              );
              setState(() {});
            }
            else {
              if (EnteringScore == 163 ||
                  EnteringScore == 166 ||
                  EnteringScore == 169 ||
                  EnteringScore == 172 ||
                  EnteringScore == 173 ||
                  EnteringScore == 175 ||
                  EnteringScore == 176 ||
                  EnteringScore == 178 ||
                  EnteringScore == 179 ||
                  EnteringScore > 180) {
                chance = !chance;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    width: w * 0.9,
                    behavior: SnackBarBehavior.floating,
                    content: Center(
                      child: Text(
                        'Cannot be Possible',
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: kWhite, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    backgroundColor: kError,
                    duration: Duration(seconds: 2),
                  ),
                );
                setState(() {});
              }
              else {
                if (First! - EnteringScore == 1) {
                  chance = !chance;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      width: w * 0.9,
                      behavior: SnackBarBehavior.floating,
                      content: Center(
                        child: Text(
                          'Cannot be Possible',
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: kWhite, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      backgroundColor: kError,
                      duration: Duration(seconds: 2),
                    ),
                  );
                  setState(() {});
                }
                else {
                  if (First! < EnteringScore) {
                    chance = !chance;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        width: w * 0.9,
                        behavior: SnackBarBehavior.floating,
                        content: Center(
                          child: Text(
                            'Cannot be Possible',
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
                    setState(() {});
                  }
                  else {
                    voice(EnteringScore);
                    First = First! - EnteringScore;
                    FirstScoreList.add(First!);
                    EnterFirstScoreList.add(EnteringScore);

                    print("First Score List :- $FirstScoreList");
                    ScoreEntering = "";
                    EnteringScore = 0;
                    LastScoreFirst =
                        EnterFirstScoreList[EnterFirstScoreList.length - 1];
                    DartsFirst += 3;

                    int sum = 0;
                    for (int i = 0; i < EnterFirstScoreList.length; i++) {
                      sum += EnterFirstScoreList[i];
                    }

                    ListAverageFirst.add(((sum) / DartsFirst) * 3);
                    print("Average List :- $ListAverageFirst");
                    averageFirst =
                        ListAverageFirst[ListAverageFirst.length - 1];

                    setState(() {});
                    Future.delayed(
                      Duration(seconds: 3),
                      () {
                        if ((int.parse(Leg) / 2) > LegsFirst && Second != 101) {
                          requiredVoice(Second!);
                        }
                      },
                    );

                    if (First == 0) {
                      start = !start;
                      print("Start :- $start");
                      LegsFirst++;
                      chance = !start;
                      print("New Leg Start :- $chance");
                      First = int.parse(Score);
                      Second = int.parse(Score);

                      setState(() {});

                      if ((int.parse(Leg) / 2) > LegsFirst) {
                        Future.delayed(
                          Duration(seconds: 2),
                          () {
                            requiredVoice(0);
                          },
                        );
                      }
                      if ((int.parse(Leg) / 2) < LegsFirst) {
                        print("1");
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return FrostedGlass(
                                widget: InfoCard("$FirstPlayer"));
                          },
                        );
                        Future.delayed(
                          Duration(seconds: 2),
                          () {
                            requiredVoice(0);
                          },
                        );
                      }
                    }
                  }
                }
              }
            }
          } else {
            if (ScoreEntering.isEmpty) {
              chance = !chance;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  width: w * 0.9,
                  behavior: SnackBarBehavior.floating,
                  content: Center(
                    child: Text(
                      'Enter Score',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: kWhite, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  backgroundColor: kError,
                  duration: Duration(seconds: 2),
                ),
              );
              setState(() {});
            } else {
              if (EnteringScore == 163 ||
                  EnteringScore == 166 ||
                  EnteringScore == 169 ||
                  EnteringScore == 172 ||
                  EnteringScore == 173 ||
                  EnteringScore == 175 ||
                  EnteringScore == 176 ||
                  EnteringScore == 178 ||
                  EnteringScore == 179 ||
                  EnteringScore > 180) {
                chance = !chance;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    width: w * 0.9,
                    behavior: SnackBarBehavior.floating,
                    content: Center(
                      child: Text(
                        'Cannot be Possible',
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: kWhite, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    backgroundColor: kError,
                    duration: Duration(seconds: 2),
                  ),
                );
                setState(() {});
              } else {
                if (Second! - EnteringScore == 1) {
                  chance = !chance;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      width: w * 0.9,
                      behavior: SnackBarBehavior.floating,
                      content: Center(
                        child: Text(
                          'Cannot be Possible',
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: kWhite, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      backgroundColor: kError,
                      duration: Duration(seconds: 2),
                    ),
                  );
                  setState(() {});
                } else {
                  if (Second! < EnteringScore) {
                    chance = !chance;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        width: w * 0.9,
                        behavior: SnackBarBehavior.floating,
                        content: Center(
                          child: Text(
                            'Cannot be Possible',
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
                    setState(() {});
                  } else {
                    voice(EnteringScore);
                    Second = Second! - EnteringScore;
                    SecondScoreList.add(Second!);
                    EnterSecondScoreList.add(EnteringScore);
                    print("Second Score List :- $SecondScoreList");
                    ScoreEntering = "";
                    EnteringScore = 0;
                    LastScoreSecond =
                        EnterSecondScoreList[EnterSecondScoreList.length - 1];
                    DartsSecond += 3;

                    int sum = 0;
                    for (int i = 0; i < EnterSecondScoreList.length; i++) {
                      sum += EnterSecondScoreList[i];
                    }

                    ListAverageSecond.add(((sum) / DartsSecond) * 3);
                    averageSecond =
                        ListAverageSecond[ListAverageSecond.length - 1];

                    setState(() {});
                    Future.delayed(
                      Duration(seconds: 3),
                      () {
                        if ((int.parse(Leg) / 2) > LegsSecond && First != 101)
                          requiredVoice(First!);
                      },
                    );

                    if (Second == 0) {
                      start = !start;
                      LegsSecond++;
                      chance = !start;
                      First = int.parse(Score);
                      Second = int.parse(Score);

                      setState(() {});
                      if ((int.parse(Leg) / 2) > LegsSecond) {
                        Future.delayed(
                          Duration(seconds: 2),
                          () {
                            requiredVoice(0);
                          },
                        );
                      }
                      if ((int.parse(Leg) / 2) < LegsSecond) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return FrostedGlass(
                                widget: InfoCard("$SecondPlayer"));
                          },
                        );

                        Future.delayed(
                          Duration(seconds: 2),
                          () {
                            requiredVoice(0);
                          },
                        );
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
      else if (Mode == "First Of") {
        if (int.parse(Leg) > LegsFirst && int.parse(Leg) > LegsSecond) {
          if (chance == true) {
            if (ScoreEntering.isEmpty) {
              chance = !chance;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  width: w * 0.9,
                  behavior: SnackBarBehavior.floating,
                  content: Center(
                    child: Text(
                      'Enter Score',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: kWhite, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  backgroundColor: kError,
                  duration: Duration(seconds: 2),
                ),
              );
              setState(() {});
            }
            else {
              if (EnteringScore == 163 ||
                  EnteringScore == 166 ||
                  EnteringScore == 169 ||
                  EnteringScore == 172 ||
                  EnteringScore == 173 ||
                  EnteringScore == 175 ||
                  EnteringScore == 176 ||
                  EnteringScore == 178 ||
                  EnteringScore == 179 ||
                  EnteringScore > 180) {
                chance = !chance;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    width: w * 0.9,
                    behavior: SnackBarBehavior.floating,
                    content: Center(
                      child: Text(
                        'Cannot be Possible',
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: kWhite, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    backgroundColor: kError,
                    duration: Duration(seconds: 2),
                  ),
                );
                setState(() {});
              } else {
                if (First! - EnteringScore == 1) {
                  chance = !chance;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      width: w * 0.9,
                      behavior: SnackBarBehavior.floating,
                      content: Center(
                        child: Text(
                          'Cannot be Possible',
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: kWhite, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      backgroundColor: kError,
                      duration: Duration(seconds: 2),
                    ),
                  );
                  setState(() {});
                } else {
                  if (First! < EnteringScore) {
                    chance = !chance;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        width: w * 0.9,
                        behavior: SnackBarBehavior.floating,
                        content: Center(
                          child: Text(
                            'Cannot be Possible',
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
                    setState(() {});
                  } else {
                    voice(EnteringScore);
                    First = First! - EnteringScore;
                    FirstScoreList.add(First!);
                    EnterFirstScoreList.add(EnteringScore);
                    print("First Score List :- $FirstScoreList");
                    ScoreEntering = "";
                    EnteringScore = 0;
                    LastScoreFirst =
                        EnterFirstScoreList[EnterFirstScoreList.length - 1];
                    DartsFirst += 3;

                    int sum = 0;
                    for (int i = 0; i < EnterFirstScoreList.length; i++) {
                      sum += EnterFirstScoreList[i];
                    }

                    ListAverageFirst.add(((sum) / DartsFirst) * 3);
                    averageFirst =
                        ListAverageFirst[ListAverageFirst.length - 1];

                    setState(() {});
                    Future.delayed(
                      Duration(seconds: 3),
                      () {
                        if ((int.parse(Leg)) > LegsFirst && First != 101)
                          requiredVoice(Second!);
                      },
                    );

                    if (First == 0) {
                      start = !start;
                      LegsFirst++;
                      chance = !start;
                      First = int.parse(Score);
                      Second = int.parse(Score);
                      setState(() {});
                      if ((int.parse(Leg)) > LegsFirst) {
                        Future.delayed(
                          Duration(seconds: 2),
                          () {
                            requiredVoice(0);
                          },
                        );
                      }
                      if ((int.parse(Leg)) == LegsFirst) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return FrostedGlass(
                                widget: InfoCard("$FirstPlayer"));
                          },
                        );

                        Future.delayed(
                          Duration(seconds: 2),
                          () {
                            requiredVoice(0);
                          },
                        );
                      }
                    }
                  }
                }
              }
            }
          } else {
            if (ScoreEntering.isEmpty) {
              chance = !chance;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  width: w * 0.9,
                  behavior: SnackBarBehavior.floating,
                  content: Center(
                    child: Text(
                      'Enter Score',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: kWhite, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  backgroundColor: kError,
                  duration: Duration(seconds: 2),
                ),
              );
              setState(() {});
            } else {
              if (EnteringScore == 163 ||
                  EnteringScore == 166 ||
                  EnteringScore == 169 ||
                  EnteringScore == 172 ||
                  EnteringScore == 173 ||
                  EnteringScore == 175 ||
                  EnteringScore == 176 ||
                  EnteringScore == 178 ||
                  EnteringScore == 179 ||
                  EnteringScore > 180) {
                chance = !chance;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    width: w * 0.9,
                    behavior: SnackBarBehavior.floating,
                    content: Center(
                      child: Text(
                        'Cannot be Possible',
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: kWhite, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    backgroundColor: kError,
                    duration: Duration(seconds: 2),
                  ),
                );
                setState(() {});
              } else {
                if (Second! - EnteringScore == 1) {
                  chance = !chance;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      width: w * 0.9,
                      behavior: SnackBarBehavior.floating,
                      content: Center(
                        child: Text(
                          'Cannot be Possible',
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: kWhite, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      backgroundColor: kError,
                      duration: Duration(seconds: 2),
                    ),
                  );
                  setState(() {});
                } else {
                  if (Second! < EnteringScore) {
                    chance = !chance;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        width: w * 0.9,
                        behavior: SnackBarBehavior.floating,
                        content: Center(
                          child: Text(
                            'Cannot be Possible',
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
                    setState(() {});
                  } else {
                    voice(EnteringScore);
                    Second = Second! - EnteringScore;
                    SecondScoreList.add(Second!);
                    EnterSecondScoreList.add(EnteringScore);
                    print("Second Score List :- $SecondScoreList");
                    ScoreEntering = "";
                    EnteringScore = 0;
                    LastScoreSecond =
                        EnterSecondScoreList[EnterSecondScoreList.length - 1];
                    DartsSecond += 3;

                    int sum = 0;
                    for (int i = 0; i < EnterSecondScoreList.length; i++) {
                      sum += EnterSecondScoreList[i];
                    }

                    ListAverageSecond.add(((sum) / DartsSecond) * 3);
                    averageSecond =
                        ListAverageSecond[ListAverageSecond.length - 1];

                    setState(() {});
                    Future.delayed(
                      Duration(seconds: 3),
                      () {
                        if ((int.parse(Leg)) > LegsSecond && Second != 101)
                          requiredVoice(First!);
                      },
                    );

                    if (Second == 0) {
                      start = !start;
                      LegsSecond++;
                      chance = !start;
                      First = int.parse(Score);
                      Second = int.parse(Score);
                      setState(() {});
                      if ((int.parse(Leg)) > LegsSecond) {
                        Future.delayed(
                          Duration(seconds: 2),
                          () {
                            requiredVoice(0);
                          },
                        );
                      }
                      if ((int.parse(Leg)) == LegsSecond) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return FrostedGlass(
                                widget: InfoCard("$SecondPlayer"));
                          },
                        );
                        Future.delayed(
                          Duration(seconds: 2),
                          () {
                            requiredVoice(0);
                          },
                        );
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    else if (Data == "undo") {
      chance = !chance;
      setState(() {});
      if (chance == true) {
        if (FirstScoreList.length == 1) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              width: w * 0.9,
              behavior: SnackBarBehavior.floating,
              content: Center(
                child: Text(
                  'Undo Not Possible',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: kWhite, fontWeight: FontWeight.bold)),
                ),
              ),
              backgroundColor: kError,
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          FirstScoreList.removeLast();
          EnterFirstScoreList.removeLast();
          if (EnterFirstScoreList.isEmpty) {
            LastScoreFirst = 0;
          }
          First = FirstScoreList[FirstScoreList.length - 1];
          DartsFirst -= 3;
          chance = !chance;
          ListAverageFirst.removeLast();
          print("Average List removed :- $ListAverageFirst");
          if (ListAverageFirst.isEmpty) {
            averageFirst = 0.0;
          } else {
            averageFirst = ListAverageFirst[ListAverageFirst.length - 1];
          }
          setState(() {});
        }
      } else {
        if (SecondScoreList.length == 1) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              width: w * 0.9,
              behavior: SnackBarBehavior.floating,
              content: Center(
                child: Text(
                  'Undo Not Possible',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: kWhite, fontWeight: FontWeight.bold)),
                ),
              ),
              backgroundColor: kError,
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          SecondScoreList.removeLast();
          EnterSecondScoreList.removeLast();
          if (EnterSecondScoreList.isEmpty) {
            LastScoreSecond = 0;
          }
          DartsSecond -= 3;
          Second = SecondScoreList[SecondScoreList.length - 1];
          chance = !chance;
          ListAverageSecond.removeLast();
          if (ListAverageSecond.isEmpty) {
            averageSecond = 0.0;
          } else {
            averageSecond = ListAverageSecond[ListAverageSecond.length - 1];
          }
          setState(() {});
        }
      }
    }
    else if (Data == "bust") {
      if (chance == true) {
        voice(0);
        First = First! - 0;
        FirstScoreList.add(First!);
        EnterFirstScoreList.add(0);
        DartsFirst += 3;
        chance = !chance;
        setState(() {});
      } else {
        voice(0);
        Second = Second! - 0;
        SecondScoreList.add(Second!);
        EnterSecondScoreList.add(0);
        DartsSecond += 3;
        chance = !chance;
        setState(() {});
      }
    }
    else {
      if (ScoreEntering.length <= 2) {
        ScoreEntering += Data;
      }

      EnteringScore = int.parse(ScoreEntering);
      print("Entering Score :- $ScoreEntering");

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return FrostedGlass(widget: exitCard());
          },
        );

        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xfff4f4f4),
          appBar: PreferredSize(
            child: Container(
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: w,
                    height: h * 0.1,
                    decoration: BoxDecoration(
                        color: kBg,
                        boxShadow: [
                          BoxShadow(
                              color: kWhite.withOpacity(0.1),
                              offset: Offset(2, 4),
                              blurRadius: 20,
                              spreadRadius: -17)
                        ]),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: textWidget(
                              msg: "$Score - $Mode $Leg",
                              txtColor: kWhite,
                              txtFontWeight: FontWeight.w600,
                              txtFontSize: h * 0.025),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: IconButton(
                              onPressed: () {
                                lightImpact();

                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return FrostedGlass(widget: exitCard());
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.close,
                                color: kWhite,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            preferredSize: Size(w, h * 0.065),
          ),

          body: Column(
            children: [

              // Scores
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: h * 0.2,
                      margin: EdgeInsets.only(left: 15, right: 10, top: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: chance ? kChance : kNotChance,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: kBlack,
                            blurRadius: 10,
                            spreadRadius: -10
                          )
                        ]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textWidget(
                              msg: "$First",
                              txtColor: chance ? kChanceScore : kNotChance,
                              txtFontWeight: FontWeight.bold,
                              txtFontSize: h * 0.06),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          textWidget(
                              msg: "Last Score : $LastScoreFirst",
                              txtColor: chance ? kGreen : kWhite,
                              txtFontWeight: FontWeight.w600,
                              txtFontSize: h * 0.018),
                          SizedBox(
                            height: h * 0.005,
                          ),
                          textWidget(
                              msg: "Darts : $DartsFirst",
                              txtColor: chance ? kGreen : kWhite,
                              txtFontWeight: FontWeight.w600,
                              txtFontSize: h * 0.018),
                          SizedBox(
                            height: h * 0.005,
                          ),
                          textWidget(
                              msg:
                                  "Average : ${averageFirst.toStringAsFixed(2)}",
                              txtColor: chance ? kGreen : kWhite,
                              txtFontWeight: FontWeight.w600,
                              txtFontSize: h * 0.018),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: h * 0.2,
                      margin: EdgeInsets.only(top: 10, left: 10, right: 15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: chance ? kNotChance : kChance,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textWidget(
                              msg: "$Second",
                              txtColor: chance ? kNotChanceScore : kChanceScore,
                              txtFontWeight: FontWeight.bold,
                              txtFontSize: h * 0.06),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          textWidget(
                              msg: "Last Score : $LastScoreSecond",
                              txtColor: chance ? kWhite : kGreen,
                              txtFontWeight: FontWeight.w600,
                              txtFontSize: h * 0.018),
                          SizedBox(
                            height: h * 0.005,
                          ),
                          textWidget(
                              msg: "Darts : $DartsSecond",
                              txtColor: chance ? kWhite : kGreen,
                              txtFontWeight: FontWeight.w600,
                              txtFontSize: h * 0.018),
                          SizedBox(
                            height: h * 0.005,
                          ),
                          textWidget(
                              msg:
                                  "Average : ${averageSecond.toStringAsFixed(2)}",
                              txtColor: chance ? kWhite : kGreen,
                              txtFontWeight: FontWeight.w600,
                              txtFontSize: h * 0.018),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Enter Undo
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        heavyImpact();

                        btnClick("undo");
                        chance = !chance;
                        print("Chance = $chance");
                        setState(() {});
                      },
                      child: Container(
                          height: h * 0.06,
                          margin: EdgeInsets.only(left: 15, right: 5, top: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: kError,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Image.asset(
                            "images/undo.png",
                            width: w * 0.06,
                            color: kWhite,
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: h * 0.07,
                      margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: kWhite.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: _speechToText.isNotListening
                                  ? _startListening
                                  : _stopListening,
                              child: Container(
                                height: h * 0.06,
                                width: h * 0.05,
                                child: Image.asset("images/mic.png",),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: textWidget(
                                msg: _speechToText.isListening
                                    ? SpeekWord
                                    : "${ScoreEntering}",
                                txtColor: kWhite,
                                txtFontWeight: FontWeight.bold,
                                txtFontSize: h * 0.03),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        heavyImpact();

                        btnClick("enter");
                        chance = !chance;
                        print("Chance = $chance");
                        setState(() {});
                      },
                      child: Container(
                        height: h * 0.06,
                        margin: EdgeInsets.only(top: 20, left: 5, right: 15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: kNamePlat,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: textWidget(
                            msg: "Enter",
                            txtColor: kWhite,
                            txtFontWeight: FontWeight.bold,
                            txtFontSize: h * 0.021),
                      ),
                    ),
                  ),
                ],
              ),

              // 1 2 3 button
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        lightImpact();

                        btnClick("1");
                      },
                      child: Container(
                        height: h * 0.1,
                        margin: EdgeInsets.only(left: 15, right: 5, top: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kWhite.withOpacity(0.09),
                        ),
                        child: textWidget(
                            msg: "1",
                            txtColor: kWhite,
                            txtFontWeight: FontWeight.bold,
                            txtFontSize: h * 0.035),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        lightImpact();

                        btnClick("2");
                      },
                      child: Container(
                        height: h * 0.1,
                        margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kWhite.withOpacity(0.09),
                        ),
                        child: textWidget(
                            msg: "2",
                            txtColor: kWhite,
                            txtFontWeight: FontWeight.bold,
                            txtFontSize: h * 0.035),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        lightImpact();
                        btnClick("3");
                      },
                      child: Container(
                        height: h * 0.1,
                        margin: EdgeInsets.only(left: 5, right: 15, top: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kWhite.withOpacity(0.09),
                        ),
                        child: textWidget(
                            msg: "3",
                            txtColor: kWhite,
                            txtFontWeight: FontWeight.bold,
                            txtFontSize: h * 0.035),
                      ),
                    ),
                  ),
                ],
              ),

              // 4 5 6 button
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        lightImpact();

                        btnClick("4");
                      },
                      child: Container(
                        height: h * 0.1,
                        margin: EdgeInsets.only(left: 15, right: 5, top: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kWhite.withOpacity(0.09),
                        ),
                        child: textWidget(
                            msg: "4",
                            txtColor: kWhite,
                            txtFontWeight: FontWeight.bold,
                            txtFontSize: h * 0.035),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        lightImpact();
                        btnClick("5");
                      },
                      child: Container(
                        height: h * 0.1,
                        margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kWhite.withOpacity(0.09),
                        ),
                        child: textWidget(
                            msg: "5",
                            txtColor: kWhite,
                            txtFontWeight: FontWeight.bold,
                            txtFontSize: h * 0.035),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        lightImpact();
                        btnClick("6");
                      },
                      child: Container(
                        height: h * 0.1,
                        margin: EdgeInsets.only(left: 5, right: 15, top: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kWhite.withOpacity(0.09),
                        ),
                        child: textWidget(
                            msg: "6",
                            txtColor: kWhite,
                            txtFontWeight: FontWeight.bold,
                            txtFontSize: h * 0.035),
                      ),
                    ),
                  ),
                ],
              ),

              // 7 8 9 button
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        lightImpact();
                        btnClick("7");
                      },
                      child: Container(
                        height: h * 0.1,
                        margin: EdgeInsets.only(left: 15, right: 5, top: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kWhite.withOpacity(0.09),
                        ),
                        child: textWidget(
                            msg: "7",
                            txtColor: kWhite,
                            txtFontWeight: FontWeight.bold,
                            txtFontSize: h * 0.035),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        lightImpact();
                        btnClick("8");
                      },
                      child: Container(
                        height: h * 0.1,
                        margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kWhite.withOpacity(0.09),
                        ),
                        child: textWidget(
                            msg: "8",
                            txtColor: kWhite,
                            txtFontWeight: FontWeight.bold,
                            txtFontSize: h * 0.035),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        lightImpact();
                        btnClick("9");
                      },
                      child: Container(
                        height: h * 0.1,
                        margin: EdgeInsets.only(left: 5, right: 15, top: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kWhite.withOpacity(0.09),
                        ),
                        child: textWidget(
                            msg: "9",
                            txtColor: kWhite,
                            txtFontWeight: FontWeight.bold,
                            txtFontSize: h * 0.035),
                      ),
                    ),
                  ),
                ],
              ),

              // bust 0 bake button
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        lightImpact();
                        btnClick("bust");
                      },
                      child: Container(
                        height: h * 0.1,
                        margin: EdgeInsets.only(left: 15, right: 5, top: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kWhite.withOpacity(0.09),
                        ),
                        child: textWidget(
                            msg: "Bust",
                            txtColor: kWhite,
                            txtFontWeight: FontWeight.w700,
                            txtFontSize: h * 0.023),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        lightImpact();
                        btnClick("0");
                      },
                      child: Container(
                        height: h * 0.1,
                        margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kWhite.withOpacity(0.09),
                        ),
                        child: textWidget(
                            msg: "0",
                            txtColor: kWhite,
                            txtFontWeight: FontWeight.bold,
                            txtFontSize: h * 0.035),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        lightImpact();
                        btnClick("back");
                      },
                      child: Container(
                          height: h * 0.1,
                          margin: EdgeInsets.only(left: 5, right: 15, top: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kWhite.withOpacity(0.09),
                          ),
                          child: Image.asset(
                            "images/delete.png",
                            width: w * 0.06,
                            color: kWhite,
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
