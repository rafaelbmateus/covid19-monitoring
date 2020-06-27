import 'dart:isolate';
import 'dart:ui';

import 'package:background_locator/background_locator.dart';
import 'package:background_locator/location_dto.dart';
import 'package:background_locator/location_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19/src/model/coordinate.dart';
import 'package:covid19/src/model/user.dart';
import 'package:covid19/src/services/database.dart';
import 'package:covid19/src/services/sharedPref.dart';

class LocationService {
  ReceivePort foregroundPort;

  Future<void> locationTrackingCallback(String uid, dynamic data) async {
    SharedPref sharedPref = SharedPref();
    UserData user = UserData.fromJson(await sharedPref.read("user"));

    GeoPoint geoPoint = new GeoPoint(data.latitude, data.longitude);
    await DatabaseService(uid: uid)
        .coordinateSave(Coordinate(cpf: user.cpf, geoPoint: geoPoint));
  }

  Future<void> startService(User user) async {
    foregroundPort = ReceivePort();
    IsolateNameServer.registerPortWithName(
        foregroundPort.sendPort, 'LocatorIsolate');
    foregroundPort.listen((dynamic data) {
      var uid = user.uid;
      locationTrackingCallback(uid, data);
    });
    await BackgroundLocator.initialize();
    LocationSettings settings = LocationSettings(
        interval: 900, // 15 minutes
        notificationTitle: 'Location',
        notificationMsg: 'Location is being tracked');
    BackgroundLocator.registerLocationUpdate(_updateCallback,
        settings: settings);
  }

  Future<void> stopService() async {
    await BackgroundLocator.unRegisterLocationUpdate();
    IsolateNameServer.removePortNameMapping('LocatorIsolate');
  }

  static void _updateCallback(LocationDto locationDto) async {
    final SendPort send = IsolateNameServer.lookupPortByName('LocatorIsolate');
    send?.send(locationDto);
  }
}
