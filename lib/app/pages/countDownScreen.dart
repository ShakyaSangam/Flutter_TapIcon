import 'package:flutter/material.dart';

class CountDownScreen extends StatefulWidget {
  CountDownScreen({this.countDown});
  final int countDown;
  @override
  _CountDownScreenState createState() => _CountDownScreenState();
}

class _CountDownScreenState extends State<CountDownScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Start Tapping In",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              widget.countDown.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
