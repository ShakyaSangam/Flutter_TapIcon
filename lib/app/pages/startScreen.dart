import 'package:flutter/material.dart';
import 'package:flutter_tapicon/gameScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int highestScore = 0;
  @override
  void initState() {
    super.initState();
    fetchhScore();
  }

  Future<void> fetchhScore() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      highestScore = sharedPreferences.getInt("highscore");
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
            child: _userScoreBoard(),
          ),
        ),
      ),
      floatingActionButton: buildFloatingActionButton(context),
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
      },
      child: Icon(
        Icons.play_arrow,
        size: 28,
        color: Colors.pink,
      ),
    );
  }

  Column _userScoreBoard() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                "HighScore",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                highestScore.toString(),
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
