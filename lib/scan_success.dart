import 'dart:async';

import 'package:bus_application/ticketing_backend.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScanSuccess extends StatefulWidget {
  final String journeyType;
  final String? scanData;

  const ScanSuccess({Key? key, required this.journeyType, this.scanData})
      : super(key: key);

  @override
  State createState() => _ScanSuccess();
}

class _ScanSuccess extends State<ScanSuccess> {
  late Timer _timer;
  int _start = 5;

  String username = '';

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          timer.cancel();
          Navigator.pop(context);
        } else {
          if (mounted) {
            setState(() {
              _start--;
            });
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    getName();
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Column(
          children: [
            Text(
              "Hi $username, you have successfully ${widget.journeyType} the journey",
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

  void getName() async {
    var api = TicketingBackend();
    var data = await api.getFromStorage();
    if (mounted) {
      setState(() {
        username = data.data.data.firstName;
      });
    }
  }
}
