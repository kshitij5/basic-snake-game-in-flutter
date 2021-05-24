import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  var _height, _width, sensitivity = 0, direction = 'up';
  static List<int> menuLocation = [
    162,
    161,
    181,
    201,
    202,
    222,
    241,
    242,
    164,
    184,
    204,
    224,
    244,
    185,
    206,
    167,
    187,
    207,
    227,
    247,
    170,
    189,
    209,
    229,
    249,
    191,
    211,
    231,
    251,
    230,
    175,
    173,
    193,
    213,
    233,
    253,
    195,
    214,
    235,
    255,
    177,
    197,
    217,
    237,
    257,
    178,
    218,
    258
  ];
  static int pixels = 720;

  static List<int> playbutton = [389, 409, 429, 449, 469, 410, 430, 450, 431];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => GamePage()));
        },
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 20, crossAxisSpacing: 2, mainAxisSpacing: 2),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (menuLocation.contains(index)) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  //border: Border.all(color: Colors.blueAccent)
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  //boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))]
                ),
              );
            }
            if (playbutton.contains(index)) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white10, //index == 389?Colors.green:
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                //child: Center(child: Text(index.toString(),)),
              );
            }
          },
          itemCount: pixels,
        ),
      ),
    );
  }
}

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  var _height, _width, sensitivity = 0, direction = 'up';
  static List<int> snakeLocation = [40, 60, 80, 100];
  static int pixels = 720;

  ///GENERATING FOOD LOCATION
  static Random random = new Random();
  int foodLocation = random.nextInt(pixels);

  void generateFood() {
    foodLocation = random.nextInt(pixels);
  }

  ///GENERATING SNAKE LOCATION
  void generateSnake() {
    snakeLocation = [40, 60, 80, 100];
    const duration = const Duration(milliseconds: 200);
    Timer.periodic(duration, (Timer timer) {
      updateSnake();
    });
  }

  ///UPDATE SNAKE CURRENT POSITION
  void updateSnake() {
    setState(() {
      switch (direction) {
        case 'up':
          if (snakeLocation.last < 20)
            snakeLocation.add(snakeLocation.last - 20 + 640);
          else
            snakeLocation.add(snakeLocation.last - 20);
          break;
        case 'down':
          if (snakeLocation.last > 640)
            snakeLocation.add(snakeLocation.last + 20 - 640);
          else
            snakeLocation.add(snakeLocation.last + 20);
          break;
        case 'left':
          if (snakeLocation.last % 20 == 0)
            snakeLocation.add(snakeLocation.last - 1 + 20);
          else
            snakeLocation.add(snakeLocation.last - 1);
          break;
        case 'right':
          if ((snakeLocation.last + 1) % 20 == 0)
            snakeLocation.add(snakeLocation.last + 1 - 20);
          else
            snakeLocation.add(snakeLocation.last + 1);
          break;
      }

      if (snakeLocation.last == foodLocation)
        generateFood();
      else
        snakeLocation.removeAt(0);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generateSnake();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black87,
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          // Note: Sensitivity is integer used when you don't want to mess up vertical drag
          if (details.delta.dx > sensitivity) {
            direction = 'right';
            // Right Swipe
          } else if (details.delta.dx < -sensitivity) {
            direction = 'left';
            //Left Swipe
          }
        },
        onVerticalDragUpdate: (details) {
          // print(details.delta.dy.floor());
          // Note: Sensitivity is integer used when you don't want to mess up vertical drag
          if (details.delta.dy < -sensitivity) {
            direction = 'up';
            // Up Swipe
          } else if (details.delta.dy > sensitivity) {
            direction = 'down';
            //Down Swipe
          }
        },
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 20, crossAxisSpacing: 2, mainAxisSpacing: 2),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (snakeLocation.contains(index)) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  //border: Border.all(color: Colors.blueAccent)
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  //boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))]
                ),
              );
            }
            if (index == foodLocation) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  //border: Border.all(color: Colors.blueAccent)
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  //boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))]
                ),
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white10,
                  //border: Border.all(color: Colors.blueAccent)
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                // child: Text(index.toString(),),
              );
            }
          },
          itemCount: pixels,
        ),
      ),
    );
  }
}
