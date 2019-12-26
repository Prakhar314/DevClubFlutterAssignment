import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:flutter/services.dart';

void main(List<String> args) {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double offX = 0;
  double offY = 0;
  String buttonText = "Begin";
  var accelerE;
  var accelerEv;
  var timer;
  int timeInside = 0;
  var purpleColor = Color.fromRGBO(120, 2, 255, 0.8);
  var greenColor = Color.fromRGBO(0, 255, 0, 0.8);
  var blColor = Color.fromRGBO(0, 120, 120, 0.8);
  var currentColor = Color.fromRGBO(120, 2, 255, 0.8);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Accelerometer"),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: Text("Keep the circle at the center for 1 second"),
              padding: EdgeInsets.all(2),
              height: height,
              width: width,
              alignment: Alignment.topCenter,
            ),
            Positioned(
              top: 0.1 * width,
              left: 0.1 * width,
              child: Container(
                height: 0.8 * width,
                width: 0.8 * width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.4 * width),
                  border: Border.all(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    width: 2,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0.3 * width,
              left: 0.3 * width,
              child: Container(
                height: 0.4 * width,
                width: 0.4 * width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.2 * width),
                  border: Border.all(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    width: 2,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0.3 * width + offY,
              left: 0.3 * width - offX,
              child: Container(
                height: 0.4 * width,
                width: 0.4 * width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0.2 * width),
                    color: currentColor),
              ),
            ),
            Positioned(
              bottom: 0.3 * width,
              left: 0.45 * width,
              child: Text(
                  "x : ${(accelerEv != null) ? accelerEv.x.toStringAsFixed(3) : 0}"),
            ),
            Positioned(
              bottom: 0.25 * width,
              left: 0.45 * width,
              child: Text(
                  "y : ${(accelerEv != null) ? accelerEv.y.toStringAsFixed(3) : 0}"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (accelerE != null) {
            if (accelerE.isPaused) {
              buttonText = "Pause";
              accelerE.resume();
            } else {
              buttonText = "Resume";
              accelerE.pause();
            }
          } else {
            buttonText = "Pause";
            accelerE = accelerometerEvents.listen((AccelerometerEvent event) {
              setState(() {
                accelerEv = event;
              });
            });
            timer = Timer.periodic(Duration(milliseconds: 200), (Timer time) {
              setState(() {
                if (!accelerE.isPaused) {
                  offX = accelerEv.x * 0.06 * width;
                  if (offX > 0) {
                    offX = min(offX, 0.3 * width);
                  } else if (offX < 0) {
                    offX = max(offX, -0.3 * width);
                  }
                  offY = accelerEv.y * 0.06 * width;
                  if (offY > 0) {
                    offY = min(offY, 0.3 * width);
                  } else if (offX < 0) {
                    offY = max(offY, -0.3 * width);
                  }
                  if (offX < 1.5 && offY < 1.5 && offX > -1.5 && offY > -1.5) {
                    if (timeInside == 5) {
                      offX = 0;
                      offY = 0;
                      currentColor = greenColor;
                      buttonText = "Begin";
                      accelerE.pause();
                      timeInside = 0;
                    } else {
                      if (currentColor != blColor) {
                        currentColor = blColor;
                      }
                      timeInside += 1;
                    }
                  } else {
                    if (currentColor != purpleColor) {
                      currentColor = purpleColor;
                    }
                    timeInside = 0;
                  }
                }
              });
            });
          }
        },
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 0.02 * width),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
