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
  var timer;
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
        title: Text("MyApp"),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              height: height,
              width: width,
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
              left: 0.3 * width + offX,
              child: Container(
                height: 0.4 * width,
                width: 0.4 * width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0.2 * width),
                    color: Color.fromRGBO(120, 2, 255, 0.8)),
              ),
            ),
            Positioned(
              top: 1.2 * width,
              left: 0.35 * width,
              child: Text(
                  "x:${offX.toStringAsFixed(3)}  y:${offY.toStringAsFixed(3)}"),
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
                offX = event.x * 0.06 * width;
                if (offX > 0) {
                  offX = min(offX, 0.3 * width);
                } else if (offX < 0) {
                  offX = max(offX, -0.3 * width);
                }
                offY = event.y * 0.06 * width;
                if (offY > 0) {
                  offY = min(offY, 0.3 * width);
                } else if (offX < 0) {
                  offY = max(offY, -0.3 * width);
                }
              });
            });
          }
        },
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 0.01 * width),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
