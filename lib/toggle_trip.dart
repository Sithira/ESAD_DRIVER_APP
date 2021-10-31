import 'dart:developer';

import 'package:bus_application/modals/toggle_trip_modal.dart';
import 'package:bus_application/passenger_qr_scanner.dart';
import 'package:bus_application/ticketing_backend.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ToggleTrip extends StatefulWidget {
  const ToggleTrip({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ToggleTrip();
}

class _ToggleTrip extends State<ToggleTrip> {
  String latestTripId = '';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  void initState() {
    getLatestTripDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        latestTripId.isNotEmpty
            ? TextButton.icon(
                label: Text(
                  "END TRIP: $latestTripId",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w800),
                ),
                icon: const Icon(Icons.stop_circle),
                onPressed: () {
                  setState(() {
                    stopTrip();
                  });
                },
              )
            : TextButton.icon(
                onPressed: () {
                  setState(() {
                    startTrip();
                  });
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) => const PassengerQRScanner()));
                },
                icon: const Icon(Icons.play_circle_fill_rounded),
                label: const Text(
                  "START TRIP",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                )),
      ],
    );
  }

  void startTrip() {
    var api = TicketingBackend();
    api.startTrip(latestTripId);
    getLatestTripDetails();
  }

  void stopTrip() {
    getLatestTripDetails();
    var api = TicketingBackend();
    log("S -> LID: $latestTripId");
    api.endTrip(latestTripId);
    setState(() {
      latestTripId = '';
    });
  }

  void addLatestTripDetails({required String tripId}) async {
    await _storage.write(key: 'LATEST_TRIP_DATA', value: '000001');
  }

  void getLatestTripDetails() async {
    var data = await _storage.read(key: 'LATEST_TRIP_DATA');
    setState(() {
      log("LTD: $data");
      latestTripId = tripDataFromJson(data!).data.id.toString();
      log("LLID: $latestTripId");
    });
  }
}
