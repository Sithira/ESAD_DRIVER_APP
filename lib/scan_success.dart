import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScanSuccess extends StatefulWidget {
  final String journeyType;

  const ScanSuccess({Key? key, required this.journeyType}) : super(key: key);

  @override
  State createState() => _ScanSuccess();
}

class _ScanSuccess extends State<ScanSuccess> {
  late Timer _timer;
  int _start = 5;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            Navigator.of(context).pop();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    startTimer();
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Column(
          children: [
            Text(
              "Hi Jane, you have successfully ${widget.journeyType} the journey",
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Icon(Icons.check_circle_outline_outlined,
                color: Color(Colors.green.value), size: 50),
            const SizedBox(height: 20),
            Text("This screen will close in : $_start seconds")
          ],
        ))
      ],
    ));
  }
}
