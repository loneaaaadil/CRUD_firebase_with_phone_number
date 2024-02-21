import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/model/item.dart';
import 'package:get/get.dart';

const String TODO_COLLECTON_REF = "items";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _todosRef;

  DatabaseService() {
    _todosRef = _firestore.collection(TODO_COLLECTON_REF).withConverter<Item>(
        fromFirestore: (snapshots, _) {
          return Item.fromJson(
            snapshots.data()!,
          );
        },
        toFirestore: (item, _) => item.tojson());
  }

  Stream<QuerySnapshot> getItems() {
    return _todosRef.orderBy('createdAt').snapshots();
  }

  void addItems(Item item) async {
    _todosRef.add(item);
  }

  void updateItems(String itemId, Item item) {
    _todosRef.doc(itemId).update(item.tojson());
  }

  void deleteItem(String itemId) {
    _todosRef.doc(itemId).delete();
  }
}
