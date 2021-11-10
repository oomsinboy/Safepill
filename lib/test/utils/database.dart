import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('notes');
// ignore: unused_element
final Future<FirebaseApp> _initialization = Firebase.initializeApp();

FirebaseAuth auth = FirebaseAuth.instance;
User? user = FirebaseAuth.instance.currentUser;

class Database {
  static String? userUid;

  static Future<void> addItem({
    required String title,
    required String description,
    // ignore: non_constant_identifier_names
    required String heartrate,
    // ignore: non_constant_identifier_names
    required String data_time,
    // ignore: non_constant_identifier_names
    // ignore: non_constant_identifier_names

    //  required String time,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(user!.uid).collection('items').doc();

    /* Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
      "heartrate": heartrate,

    };*/

    await documentReferencer
        .set({
          "title": title,
          "description": description,
          "heartrate": heartrate,
          "data_time": data_time,
        })
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateItem({
    required String title,
    required String description,
    required String heartrate,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(user!.uid).collection('items').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
      "heartrate": heartrate,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readItems() {
    CollectionReference notesItemCollection =
        _mainCollection.doc(user!.uid).collection('items');

    return notesItemCollection.snapshots();
  }

  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(user!.uid).collection('items').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}
