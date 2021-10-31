import 'dart:convert' as convert;
import 'dart:developer';

import 'package:bus_application/modals/login_data_modal.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'modals/toggle_trip_modal.dart';

class TicketingBackend {
  final String baseURL = "192.168.1.5:8080";

  Future<Map<String, dynamic>> login(String username, String userType) async {
    const _storage = FlutterSecureStorage();
    // await _storage.deleteAll();
    var jsonBody =
        convert.jsonEncode({'mobileNumber': username, 'userType': userType});

    var response = await http.post(Uri.http(baseURL, '/api/v1/user/login'),
        headers: {'Content-Type': 'application/json'}, body: jsonBody);
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    _storage.write(key: 'LOGIN_DATA', value: response.body);
    return jsonResponse;
  }

  Future<LoginData> getFromStorage() async {
    const _storage = FlutterSecureStorage();
    var fromStorage = await _storage.read(key: 'LOGIN_DATA');
    return loginDataFromJson(fromStorage!);
  }

  Future<TripData> getFromStorageTrip() async {
    const _storage = FlutterSecureStorage();
    var fromStorage = await _storage.read(key: 'LATEST_TRIP_DATA');
    log('FROM ST: $fromStorage');
    return tripDataFromJson(fromStorage!);
  }

  void startTrip(String latestTripId) async {
    const _storage = FlutterSecureStorage();
    var currentData = await getFromStorage();
    var jsonBody =
        convert.jsonEncode({'vehicleId': currentData.data.vehicle.id});
    var response = await http.post(
        Uri.http(baseURL, '/api/v1/driver/trip/start'),
        headers: {'Content-Type': 'application/json'},
        body: jsonBody);
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    log(response.body);
    await _storage.write(key: 'LATEST_TRIP_DATA', value: response.body);
  }

  void endTrip(String latestTripId) async {
    const _storage = FlutterSecureStorage();
    var currentData = await getFromStorage();
    var ltd = await getFromStorageTrip();
    var jsonBody =
    convert.jsonEncode({'vehicleId': currentData.data.vehicle.id, 'tripId': ltd.data.id});
    var response = await http.post(
        Uri.http(baseURL, '/api/v1/driver/trip/end'),
        headers: {'Content-Type': 'application/json'},
        body: jsonBody);
    var jsonResponse =
    convert.jsonDecode(response.body) as Map<String, dynamic>;
    log(response.body);
    await _storage.delete(key: 'LATEST_TRIP_DATA');
  }
}
