import 'package:cloud_firestore/cloud_firestore.dart';

class Coordinate {
  final String cpf;
  final DateTime timestamp;
  final GeoPoint geoPoint;

  Coordinate({ this.cpf, this.timestamp, this.geoPoint });
}
