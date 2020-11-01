import 'dart:async';
import 'package:flappy_bird/bariers.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYAxis=0;
  double time=0;
  double height=0;
  double Initialheight=birdYAxis;
  bool gameHasStarted =false;
  static double barrierXone =1;
  double barrierXtwo = barrierXone + 1.5;

  void jump(){
    setState(() {
      time = 0;
      Initialheight = birdYAxis;
    });

  }

  void startGame(){
    gameHasStarted=true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.04;
      height =-4.9 * time * time + 2.8 * time;
      setState(() {
        barrierXone -= 0.05;
        barrierXtwo -= 0.05;
        birdYAxis = Initialheight - height;
      });
      setState(() {
        if(barrierXone <-2){
          barrierXone += 3.5;
        }else{
          barrierXone -= 0.05;
        }
      });
      setState(() {
        if(barrierXtwo <-2){
          barrierXtwo += 3.5;
        }else{
          barrierXtwo -= 0.05;
        }
      });
      if(birdYAxis > 1){
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if (gameHasStarted){
          jump();
        }else{
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(0,birdYAxis),
                      duration: Duration(milliseconds: 0),
                      color: Colors.blue,
                      child: MyBird(),
                    ),
                    Container(
                      alignment: Alignment(0,-0.3),
                      child: gameHasStarted ? Text("") : Text("Tap To Play",style: TextStyle(
                        letterSpacing: 4,
                        color: Colors.white,
                        fontSize: 20
                      ),),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXone,1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 100.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXone,-1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 100.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXtwo,1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 150.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXtwo,-1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 250.0,
                      ),
                    ),
                  ],
                )
            ),
            Container(
              height: 15,
              color: Colors.green,
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
                        Text("Score",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        )
                          ,),
                        SizedBox(height: 20,),
                        Text("0",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35
                            )),
                      ],
                    ),
                    SizedBox(width: 20,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Best",style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        )),
                        SizedBox(height: 20,),
                        Text("0",style: TextStyle(
                            color: Colors.white,
                            fontSize: 35
                        )),
                      ],
                    )
                    ],
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
