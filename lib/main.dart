import 'dart:developer';

import 'package:bus_application/ticketing_backend.dart';
import 'package:bus_application/toggle_trip.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: MyHome()));

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyHome();
}

class _MyHome extends State<MyHome> {
  var loginName = "";

  @override
  void initState() {
    super.initState();
    log("xxx");
    var api = TicketingBackend();
    var res = api.login('0777123123', 'DRIVER');
    getLoginName();
  }

  @override
  Widget build(BuildContext context) {
    String lastTrip = "";

    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
                top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Hello, ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(loginName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 50.0,
                        fontWeight: FontWeight.w800))
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: const ToggleTrip(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getLoginName() async {
    var bnk = TicketingBackend();
    var data = await bnk.getFromStorage();
    loginName = data.data.data.firstName;
  }
}
