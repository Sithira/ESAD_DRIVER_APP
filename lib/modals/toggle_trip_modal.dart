// To parse this JSON data, do
//
//     final tripData = tripDataFromJson(jsonString);

import 'dart:convert';

TripData tripDataFromJson(String str) => TripData.fromJson(json.decode(str));

String tripDataToJson(TripData data) => json.encode(data.toJson());

class TripData {
  TripData({
    required this.timestamp,
    required this.data,
    required this.message,
    required this.status,
  });

  DateTime timestamp;
  Data data;
  String message;
  int status;

  factory TripData.fromJson(Map<String, dynamic> json) => TripData(
        timestamp: DateTime.parse(json["timestamp"]),
        data: Data.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp.toIso8601String(),
        "data": data.toJson(),
        "message": message,
        "status": status,
      };
}

class Data {
  Data({
    required this.id,
    required this.vehicleId,
    required this.currentLocation,
    this.vehicle,
    this.currentLocationData,
    required this.isCurrentTrip,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int vehicleId;
  int currentLocation;
  dynamic vehicle;
  dynamic currentLocationData;
  int isCurrentTrip;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        vehicleId: json["vehicleId"],
        currentLocation: json["currentLocation"],
        vehicle: json["vehicle"],
        currentLocationData: json["currentLocationData"],
        isCurrentTrip: json["isCurrentTrip"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vehicleId": vehicleId,
        "currentLocation": currentLocation,
        "vehicle": vehicle,
        "currentLocationData": currentLocationData,
        "isCurrentTrip": isCurrentTrip,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
