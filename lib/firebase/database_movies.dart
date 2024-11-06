import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DatabaseMovies {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference? collectionReference;

  DatabaseMovies() {
    collectionReference = firebaseFirestore.collection('movies');
  }
  Future<bool> insertar(Map<String, dynamic> movies) async {
    try {
      collectionReference!.doc().set(movies);
      return true;
    } catch (e) {
      kDebugMode ? print('el error en insertar') : 's';
    }

    return false;
  }

  Future<bool> eliminar(String UId) async {
    try {
      collectionReference!.doc(UId).delete();
      return true;
    } catch (e) {
      print('error en borrado $e');
    }
    return false;
  }

  Future<bool> Update(Map<String, dynamic> movies, String id) async {
    try {
      collectionReference!.doc(id).update(movies);
      return true;
    } catch (e) {
      print('error en la actualiseshion(que nadota dice) $e');
    }

    return false;
  }

  Stream<QuerySnapshot> Select() {
    return collectionReference!.snapshots();
  }
}
