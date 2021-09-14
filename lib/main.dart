import 'dart:async';
import 'dart:ui';

import 'package:bird/pipe.dart';
import 'package:bird/scoreboard.dart';
import 'package:flutter/material.dart';

import 'bird.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '飞翔的小鸟'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

const double gapSiz = 0.5;

class _MyHomePageState extends State<MyHomePage> {
  double birdY = 0;
  bool isRunning = false;

  double pipeSize = 200;
  double pipeOneX = 0.9;
  double pipeTwoX = 1.4;
  double gapOneCenter = 0.2;
  double gapTwoCenter = 0;
  int score = 0;
  late Timer timer;

  onJumpEnd() {
    setState(() {
      birdY = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 3 / 4;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GestureDetector(
          onTap: () {
            setState(() {
              birdY -= 0.5;
            });
          },
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Stack(children: [
                      pipe(
                          pipeX: pipeOneX,
                          pipeY: -1,
                          pipeSize: maxHeight * (gapOneCenter - 0.25 + 1) / 2),
                      pipe(
                          pipeX: pipeOneX,
                          pipeY: 1,
                          pipeSize:
                              maxHeight * (1 - (gapOneCenter + 0.25)) / 2),
                      pipe(
                          pipeX: pipeTwoX,
                          pipeY: 1,
                          pipeSize: maxHeight * (gapTwoCenter - 0.25 + 1) / 2),
                      pipe(
                          pipeX: pipeTwoX,
                          pipeY: -1,
                          pipeSize:
                              maxHeight * (1 - (gapTwoCenter + 0.25)) / 2),
                      Bird(
                        birdY: birdY,
                        onEnd: onJumpEnd(),
                      ),
                    ]),
                  ),
                  Expanded(flex: 1, child: ScoreBoard(curScore: score))
                ],
              ),
              if (isRunning == false)
                GestureDetector(
                  onTap: () {
                    startGame();
                  },
                  child: Container(
                    alignment: Alignment(0, -0.2),
                    child: Text(
                      "点击开始游戏",
                      style: TextStyle(fontSize: 48, color: Colors.green),
                    ),
                  ),
                ),
            ],
          )),
      backgroundColor: Colors.white,
    );
  }

  checkCrash(double center, pipeX) {
    if (pipeX <= -0.75) {
      if ((birdY > center + 0.25) || (birdY < center - 0.25)) {
        return true;
      }
    }
    return false;
  }

  void startGame() {
    setState(() {
      isRunning = true;
      // birdY = 1;
    });

    timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      final double newPipeOneX = pipeOneX - 0.02;
      final double newPipeTwoX = pipeTwoX - 0.02;
      bool isCrash = false;

      isCrash = checkCrash(gapOneCenter, pipeOneX);
      isCrash |= checkCrash(gapTwoCenter, pipeTwoX);

      if (pipeOneX < -0.8 || pipeTwoX < -0.8) {
        setState(() {
          score += 1;
        });
      }
      if (isCrash == true) {
        setState(() {
          isRunning = false;
          birdY = 0;
          pipeOneX = 0.9;
          pipeTwoX = 1.4;
        });
        timer.cancel();
      } else {
        setState(() {
          pipeOneX = newPipeOneX < -1 ? 1.1 : newPipeOneX;
          pipeTwoX = newPipeTwoX < -1 ? 1.1 : newPipeTwoX;
        });
      }
    });
  }
}
