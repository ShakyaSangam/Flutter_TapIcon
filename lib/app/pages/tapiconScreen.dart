import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tapicon/app/pages/scoreBoard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TapiconScreen extends StatefulWidget {
  TapiconScreen({Key key, this.title, this.screenWidth}) : super(key: key);
  final double screenWidth;
  final String title;

  @override
  _TapiconScreenState createState() => _TapiconScreenState();
}

class _TapiconScreenState extends State<TapiconScreen> {
  List colors = [
    Colors.red,
    Colors.green,
    Colors.pink,
    Colors.blue,
    Colors.orange,
    Colors.purple
  ];
  int index = 0;
  int _count = 0;
  double width = 0.0;

  bool checkValue;
  bool isIgnoring = false;
  int totalTime = 10;

  Future storingScore({int score}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    checkValue = sharedPreferences.containsKey("highscore");

    // * 😜 checking score-history of user
    if (checkValue) {
      print("highscore is heree");
      if (score < sharedPreferences.getInt("highscore")) {
        sharedPreferences.setInt("score", score);
      } else {
        sharedPreferences.setInt("highscore", score);
        sharedPreferences.setInt("score", score);
      }
    } else {
      sharedPreferences.setInt("highscore", score);
      sharedPreferences.setInt("score", score);
    }
  }

  @override
  void initState() {
    super.initState();

    // * 🕧 game timer 🕦
    _gameTimer();
  }

  void _gameTimer() {
    Timer.periodic(Duration(milliseconds: 300), (Timer timer) {
      setState(() {
        width += widget.screenWidth / 9.8;
      });

      if (timer.tick >= totalTime) {
        // * frezing user screen
        setState(() {
          isIgnoring = true;
        });

        // * 📚 storing user score points 
        storingScore(score: _count);

        // 😜
        timer.cancel();

        // * 😜 navigating to score board lads
        _navigateToScoreBoard();
      }
    });
  }

  void _navigateToScoreBoard() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> firstAnimation,
                  Animation<double> secondAnimation) =>
              ScoreBoard(),
          transitionDuration: Duration(milliseconds: 500),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondAnimation,
              Widget child) {
            var begin = Offset(100.0, 0.0);
            var end = Offset.zero;
            Curve curve = Curves.easeInCirc;

            var tween = Tween(begin: begin, end: end)
              ..chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          }),
    );
  }

  void _score() {
    setState(() {
      index = Random().nextInt(6);
    });
    _count++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors[index],
      body: _buildTapiconMainScreen(),
    );
  }

  Stack _buildTapiconMainScreen() {
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildUserScore(),
        IgnorePointer(
          ignoring: isIgnoring,
          child: GestureDetector(
            onTap: _score,
          ),
        ),
        positioned(),
      ],
    );
  }

  Positioned positioned() {
    return Positioned(
      top: 0.0,
      child: Stack(
        children: [
          Container(
            width: widget.screenWidth,
            height: 5,
            padding: EdgeInsets.only(bottom: 0.0),
            decoration: BoxDecoration(
              color: Colors.pink.shade100,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.pink.shade100,
                    blurRadius: 0.6,
                    spreadRadius: 0.8),
              ],
            ),
          ),
          Container(
            width: width,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }

  Center _buildUserScore() {
    return Center(
        child: Text(
      _count.toString(),
      style: TextStyle(
          color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
    ));
  }
}
