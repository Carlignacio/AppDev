import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider extends ChangeNotifier {
  String name = 'Learner';
  int xp = 0;
  String uid = '';
  bool initialized = false;

  Future<void> loadProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    uid = user.uid;
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (doc.exists) {
      final data = doc.data()!;
      name = data['name'] ?? name;
      xp = (data['xp'] ?? 0) as int;
    }
    initialized = true;
    notifyListeners();
  }
}
