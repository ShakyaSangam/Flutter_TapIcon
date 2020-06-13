import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tapicon/app/pages/countDownScreen.dart';
import 'package:flutter_tapicon/app/pages/tapiconScreen.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  int count = 0;
  int index = 0;
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 700), (Timer timer) {
      setState(() => count = timer.tick);
      if(timer.tick > 3){
        timer.cancel();
        index++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List _pages = [CountDownScreen(countDown: count,), TapiconScreen(screenWidth: MediaQuery.of(context).size.width,),];
    return Scaffold(
      body: _pages[index],
    );
  }
}