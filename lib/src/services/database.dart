import 'package:covid19/src/model/user.dart';
import 'package:covid19/src/model/coordinate.dart';
import 'package:covid19/src/services/sharedPref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({ this.uid });

  final CollectionReference collectionCoordinates = Firestore.instance.collection('coordinates');
  final CollectionReference collectionUsers = Firestore.instance.collection('users');

  Future<void> prefsSave(String email) async {
    SharedPref sharedPref = SharedPref();

    var user = await getUserByEmail(email);
    user.documents.forEach((data) => {
      sharedPref.save("user", data.data),
    });
  }

  Future<void> userSave(UserData userData) async {
    return await collectionUsers.document(uid).setData({
      'name': userData.name,
      'email': userData.email,
      'cpf': userData.cpf,
      'phone': userData.phone,
    });
  }

  Future<void> coordinateSave(Coordinate coordinate) async {
    return await collectionCoordinates.document().setData({
      'cpf': coordinate.cpf,
      'timestamp': DateTime.now().toUtc().millisecondsSinceEpoch,
      'geoPoint': coordinate.geoPoint,
    });
  }

  List<Coordinate> _coordinateList(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      print(doc.data);
      return Coordinate(
          geoPoint: doc.data['geoPoint'] ?? null,
      );
    }).toList();
  }

  Stream<List<Coordinate>> get coordinates {
    return collectionCoordinates.snapshots().map(_coordinateList);
  }

  Future<QuerySnapshot> getUserByEmail(String email) {
    return collectionUsers.where('email', isEqualTo: email).getDocuments();
  }
}
