import 'package:bus_application/passenger_qr_scanner.dart';
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
                    latestTripId = "";
                  });
                },
              )
            : TextButton.icon(
                onPressed: () {
                  setState(() {
                    latestTripId = "00002";
                    addLatestTripDetails(tripId: latestTripId);
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

  void addLatestTripDetails({required String tripId}) async {
    await _storage.write(key: 'LATEST_TRIP_DATA', value: '000001');
  }

  void getLatestTripDetails() async {
    var data = await _storage.read(key: 'LATEST_TRIP_DATA');
    setState(() {
      latestTripId = data as String;

    });
  }
}
