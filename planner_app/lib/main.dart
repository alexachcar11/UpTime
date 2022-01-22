import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import 'dart:async';
import 'widget/button_widget.dart';
import 'widget/gradient_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planner App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Pomodoro Timer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static int maxSeconds = 45;
  int seconds = maxSeconds;
  Timer? timer;

  void resetTimer() => setState(() => seconds = maxSeconds);

  void startTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }

    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() => seconds--);
      } else {
        stopTimer(reset: false);
      }
    });
  }

  void addTime() {
    setState(() => maxSeconds++);
    setState(() => seconds++);
  }

  void removeTime() {
    setState(() => maxSeconds--);
    setState(() => seconds--);
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: GradientCard(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              buildTimer(),
              const SizedBox(height: 80),
              buildButtons(),
            ]),
          ),
          // gradient: ,
        ),
      );
  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = seconds == 0 || seconds >= maxSeconds;

    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                  text: isRunning ? 'Pause' : 'Resume',
                  color: Colors.black,
                  backgroundColor: Colors.grey.shade800,
                  onClicked: () {
                    if (isRunning) {
                      stopTimer(reset: false);
                    } else {
                      startTimer(reset: false);
                    }
                  }),
              const SizedBox(width: 12),
              ButtonWidget(
                text: 'Cancel',
                color: Colors.black,
                backgroundColor: Colors.grey.shade800,
                onClicked: stopTimer,
              ),
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                text: 'Start Timer!',
                color: Colors.black,
                backgroundColor: Colors.grey.shade800,
                onClicked: () {
                  startTimer();
                },
              ),
              const SizedBox(height: 40),
              ButtonWidget(
                text: 'Add Time',
                color: Colors.black,
                backgroundColor: Colors.grey.shade800,
                onClicked: addTime,
              ),
              const SizedBox(height: 40),
              ButtonWidget(
                text: 'Remove Time',
                color: Colors.black,
                backgroundColor: Colors.grey.shade800,
                onClicked: removeTime,
              )
            ],
          );
  }

  Widget buildTimer() => SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: 1 - seconds / maxSeconds, // flip by removing the 1-
            valueColor: AlwaysStoppedAnimation(Colors.white),
            strokeWidth: 12,
            backgroundColor: Colors.greenAccent,
          ),
          Center(child: buildTime()),
        ],
      ));

  Widget buildTime() {
    if (seconds == 0) {
      return Icon(Icons.done, color: Colors.greenAccent, size: 112);
    } else {
      return Text('$seconds',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 80,
            fontFamily: 'Poppins',
          ));
    }
  }
}
