// To parse this JSON data, do
//
//     final loginData = loginDataFromJson(jsonString);

import 'dart:convert';

LoginData loginDataFromJson(String str) => LoginData.fromJson(json.decode(str));

String loginDataToJson(LoginData data) => json.encode(data.toJson());

class LoginData {
  LoginData({
    required this.timestamp,
    required this.data,
    required this.message,
    required this.status,
  });

  DateTime timestamp;
  LoginDataData data;
  String message;
  int status;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        timestamp: DateTime.parse(json["timestamp"]),
        data: LoginDataData.fromJson(json["data"]),
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

class LoginDataData {
  LoginDataData({
    required this.data,
    required this.vehicle,
  });

  DataData data;
  Vehicle vehicle;

  factory LoginDataData.fromJson(Map<String, dynamic> json) => LoginDataData(
        data: DataData.fromJson(json["user"]),
        vehicle: Vehicle.fromJson(json["vehicle"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "vehicle": vehicle.toJson(),
      };
}

class DataData {
  DataData({
    required this.id,
    required this.nic,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.userType,
    required this.currentBalance,
  });

  int id;
  String nic;
  String email;
  String firstName;
  String lastName;
  String mobileNumber;
  String userType;
  double currentBalance;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        id: json["id"],
        nic: json["nic"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        mobileNumber: json["mobileNumber"],
        userType: json["userType"],
        currentBalance: json["currentBalance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nic": nic,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "mobileNumber": mobileNumber,
        "userType": userType,
        "currentBalance": currentBalance,
      };
}

class Vehicle {
  Vehicle({
    required this.id,
    required this.driverId,
    required this.ownerId,
    required this.routeId,
    required this.regNo,
    required this.route,
  });

  int id;
  int driverId;
  int ownerId;
  int routeId;
  String regNo;
  Route route;

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["id"],
        driverId: json["driverId"],
        ownerId: json["ownerId"],
        routeId: json["routeId"],
        regNo: json["regNo"],
        route: Route.fromJson(json["route"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "driverId": driverId,
        "ownerId": ownerId,
        "routeId": routeId,
        "regNo": regNo,
        "route": route.toJson(),
      };
}

class Route {
  Route({
    required this.route,
    required this.routeName,
    required this.routeNumber,
    required this.startLocation,
    required this.endLocation,
    required this.startLocationName,
    required this.endLocationName,
  });

  int route;
  String routeName;
  String routeNumber;
  Location startLocation;
  Location endLocation;
  String startLocationName;
  String endLocationName;

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        route: json["id"],
        routeName: json["routeName"],
        routeNumber: json["routeNumber"],
        startLocation: Location.fromJson(json["startLocation"]),
        endLocation: Location.fromJson(json["endLocation"]),
        startLocationName: json["startLocationName"],
        endLocationName: json["endLocationName"],
      );

  Map<String, dynamic> toJson() => {
        "route": route,
        "routeName": routeName,
        "routeNumber": routeNumber,
        "startLocation": startLocation.toJson(),
        "endLocation": endLocation.toJson(),
        "startLocationName": startLocationName,
        "endLocationName": endLocationName,
      };
}

class Location {
  Location({
    required this.id,
    required this.lat,
    required this.lng,
  });

  int id;
  String lat;
  String lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lat": lat,
        "lng": lng,
      };
}
