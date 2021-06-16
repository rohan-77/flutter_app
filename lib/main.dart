import 'dart:async';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(app());
}

class app extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "clock",
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      home: homepage(),
    );
  }
}

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> with TickerProviderStateMixin {
  TabController tb;
  int hour = 0;
  int min = 0;
  int sec = 0;
  String display = "";
  bool startt = true;
  bool stopp = true;
  int time;
  bool cancel = false;
  final dur = const Duration(seconds: 1);

  @override
  void initState() {
    tb = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  void start() {
    setState(() {
      startt = false;
      stopp = false;
    });
    time = ((hour * 3600) + (min * 60) + sec);
    Timer.periodic(dur, (Timer t) {
      setState(() {
        if (time < 1 || cancel == true) {
          t.cancel();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => homepage(),
              ));
        } else if (time < 60) {
          display = time.toString();
          time = time - 1;
        } else if (time < 3600) {
          int m = time ~/ 60;
          int s = time - (60 * m);
          display = m.toString() + ":" + s.toString();
          time = time - 1;
        } else {
          int h = time ~/ 3600;
          int t = time - (3600 * h);
          int m = t ~/ 60;
          int s = t - (60 * m);
          display = h.toString() + ":" + m.toString() + ":" + s.toString();
          time = time - 1;
        }
      });
    });
  }

  void stop() {
    setState(() {
      startt = true;
      stopp = true;
      cancel = true;
      display = "";
    });
  }

  Widget timer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "HH",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    NumberPicker(
                        itemHeight: 60,
                        itemWidth: 60,
                        minValue: 0,
                        maxValue: 23,
                        value: hour,
                        onChanged: (val) {
                          setState(() {
                            hour = val;
                          });
                        })
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "MM",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    NumberPicker(
                        itemWidth: 60,
                        itemHeight: 60,
                        minValue: 0,
                        maxValue: 23,
                        value: min,
                        onChanged: (val) {
                          setState(() {
                            min = val;
                          });
                        })
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "SS",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    NumberPicker(
                        itemWidth: 60,
                        itemHeight: 60,
                        minValue: 0,
                        maxValue: 59,
                        value: sec,
                        onChanged: (val) {
                          setState(() {
                            sec = val;
                          });
                        }),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              display,
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  onPressed: startt ? start : null,
                  splashColor: Colors.black,
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 10.0,
                  ),
                  child: Text("Start",
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                      )),
                  shape: StadiumBorder(),
                ),
                MaterialButton(
                  onPressed: stopp ? null : stop,
                  splashColor: Colors.black,
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 10.0,
                  ),
                  child: Text("Stop",
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                      )),
                  shape: StadiumBorder(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///////////////////////////////////////////////////////////////

  bool sap = true;
  bool sop = true;
  bool res = true;
  String timedisplay = "00:00:00";
  var swatch = Stopwatch();
  final durr = const Duration(seconds: 1);

  void starttimer() {
    Timer(durr, run);
  }

  void run() {
    if (swatch.isRunning) {
      starttimer();
    }
    setState(() {
      timedisplay = swatch.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    });
  }

  void startstopwatch() {
    setState(() {
      sop = false;
      sap = false;
    });
    swatch.start();
    starttimer();
  }

  void stopstopwatch() {
    setState(() {
      sop = true;
      res = false;
    });
    swatch.stop();
  }

  void resetstopwatch() {
    setState(() {
      sap = true;
      res = true;
    });
    swatch.reset();
    timedisplay = "00:00:00";
  }

  Widget stopwatch() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                timedisplay,
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        MaterialButton(
                            onPressed: sop ? null : stopstopwatch,
                            color: Colors.orangeAccent,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Text(
                              "Stop",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w200,
                                color: Colors.white,
                              ),
                            ),
                            splashColor: Colors.deepPurple,
                            hoverElevation: 20.0,
                            highlightElevation: 10.0,
                            height: 40.0,
                            minWidth: 200.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        MaterialButton(
                            onPressed: res ? null : resetstopwatch,
                            color: Colors.lightBlue,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Text(
                              "Reset",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w200,
                                color: Colors.white,
                              ),
                            ),
                            splashColor: Colors.deepPurple,
                            hoverElevation: 20.0,
                            highlightElevation: 10.0,
                            height: 40.0,
                            minWidth: 200.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ],
                    ),
                    MaterialButton(
                      onPressed: sap ? startstopwatch : null,
                      color: Colors.green,
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 15.0),
                      child: Text(
                        "Start",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                        ),
                      ),
                      splashColor: Colors.deepPurple,
                      hoverElevation: 20.0,
                      highlightElevation: 10.0,
                      height: 40.0,
                      minWidth: 200.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text(
          "ROHAN",
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          tabs: <Widget>[
            Text(
              "Timer",
            ),
            Text(
              "Stopwatch",
            ),
          ],
          labelStyle: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w400,
          ),
          labelPadding: EdgeInsets.only(
            bottom: 15.0,
          ),
          unselectedLabelColor: Colors.white60,
          controller: tb,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          timer(),
          stopwatch(),
        ],
        controller: tb,
      ),
    );
  }
}
