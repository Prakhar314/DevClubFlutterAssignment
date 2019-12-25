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
  double x = 0, y = 0, z = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    
    var a = accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;
      });
    });

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
              top: 0.3 * width,
              left: 0.3 * width,
              child: Container(
                height: 0.4 * width,
                width: 0.4 * width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0.2 * width),
                    color: Color.fromRGBO(120, 2, 255, 0.8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
