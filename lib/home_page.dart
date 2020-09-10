import 'dart:async';
import 'dart:math';
import 'package:flappy_bird/barriers.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flappy_bird/constant.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Random random = new Random();
  int randNum = 0;
  int highScore = 0;
  int score = 0;
  static double birdYAxis = 0.0;
  double height = 0.0;
  double time = 0.0;
  double initHeight = birdYAxis;
  bool gameHasStart = false;
  static double barrierXOne = 1;
  double barrierXTwo = barrierXOne + 1.6;

  double barrierYBotOne = 1.2;
  double barrierYTopOne = -1.2;
  double barrierYBotTwo = 1.2;
  double barrierYTopTwo = -1.2;

  double barrierOneTopSize = 200.0;
  double barrierOneBotSize = 200.0;
  double barrierTwoTopSize = 250.0;
  double barrierTwoBotSize = 150.0;

  void resetGame() {
    setState(() {
      score = 0;
      gameHasStart = false;
      birdYAxis = 0.0;
      height = 0.0;
      time = 0.0;
      initHeight = birdYAxis;
      barrierXOne = 1;
      barrierXTwo = barrierXOne + 1.6;
      barrierOneTopSize = 200.0;
      barrierOneBotSize = 200.0;
      barrierTwoTopSize = 250.0;
      barrierTwoBotSize = 150.0;
    });
  }

  void jump() {
    setState(() {
      time = 0;
      initHeight = birdYAxis;
    });
  }

  void startGame() {
    setState(() {
      gameHasStart = true;
    });

    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = (-4.9 * time * time) + (2.8 * time);
      setState(() {
        birdYAxis = initHeight - height;
      });
      randNum = random.nextInt(200) + 100;
      setState(() {
        if (barrierXOne < -2) {
          barrierOneTopSize = randNum.toDouble();
          barrierOneBotSize = 400 - barrierOneTopSize;
          barrierXOne += 3.5;
          score++;
        } else {
          barrierXOne -= 0.05;
        }
      });

      setState(() {
        if (barrierXTwo < -2) {
          barrierTwoTopSize = randNum.toDouble();
          barrierTwoBotSize = 400 - barrierTwoTopSize;
          barrierXTwo += 3.5;
          score++;
        } else {
          barrierXTwo -= 0.05;
        }
      });

      if (birdYAxis > 0.9) {
        setState(() {
          timer.cancel();

          _showDialog();
        });
      }
    });
  }
  // bool checkIfBirdCrossBarrier()
  // {

  // }

  void _showDialog() {
    showDialog(
        useRootNavigator: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: Text(
              "GAME OVER",
              style: kTextWhiteStyle,
            ),
            content: Text(
              "Score: $score",
              style: kTextWhiteStyle,
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    if (score > highScore) {
                      highScore = score;
                    }
                    resetGame();

                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "PLAY AGAIN",
                    style: kTextWhiteStyle,
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (gameHasStart) ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdYAxis),
                    duration: Duration(milliseconds: 0),
                    color: Colors.blue,
                    child: Bird(),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXOne, barrierYBotOne),
                    duration: Duration(milliseconds: 0),
                    child: Barrier(
                      size: barrierOneBotSize,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXOne, barrierYTopOne),
                    duration: Duration(milliseconds: 0),
                    child: Barrier(
                      size: barrierOneTopSize,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXTwo, barrierYBotTwo),
                    duration: Duration(milliseconds: 0),
                    child: Barrier(
                      size: barrierTwoBotSize,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXTwo, barrierYTopTwo),
                    duration: Duration(milliseconds: 0),
                    child: Barrier(
                      size: barrierTwoTopSize,
                    ),
                  ),
                  Container(
                    alignment: Alignment(0, -0.3),
                    child: (gameHasStart)
                        ? Text("")
                        : Text(
                            "T A P  T O  P L A Y",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                  ),
                ],
              ),
            ),
            // Divider(
            //   height: 10,
            //   thickness: 5,
            // ),
            Container(
              color: Colors.green,
              height: 10,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Score",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(
                          "$score",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Best",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(
                          "$highScore",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
