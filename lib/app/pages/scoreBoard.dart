import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../gameScreen.dart';

class ScoreBoard extends StatefulWidget {
  @override
  _ScoreBoardState createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  int highestScore = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    fetchhScore();
  }

  Future<void> fetchhScore() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      highestScore = sharedPreferences.getInt("highscore");
      score = sharedPreferences.getInt("score");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width / 1.5,
          decoration: BoxDecoration(color: Colors.white),
          child: SingleChildScrollView(
            child: _buildUserScoreBoard(context),
          ),
        ),
      ),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  Column _buildUserScoreBoard(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                "Score",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                score.toString(),
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Text(
                "Highscore: ${highestScore.toString()}",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: () {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
              pageBuilder: (BuildContext context,
                      Animation<double> firstAnimation,
                      Animation<double> secondAnimation) =>
                  GameScreen(),
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
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //     builder: (context) => GameScreen()));
      },
      child: Icon(
        Icons.play_arrow,
        size: 28,
        color: Colors.pink,
      ),
    );
  }
}
