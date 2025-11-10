import 'package:cloud_firestore/cloud_firestore.dart' show FieldValue;
import 'package:flutter/material.dart';
import '../models/reward.dart';
import '../services/database_service.dart';

class RewardController extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();
  List<Reward> _rewards = [];
  bool _isLoading = false;

  List<Reward> get rewards => _rewards;
  bool get isLoading => _isLoading;

  Future<void> loadRewards() async {
    _isLoading = true;
    notifyListeners();

    try {
      _rewards = await _db.getRewards();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addPoints(String userId, int points) async {
    await _db.updateUser(userId, {
      'points': FieldValue.increment(points),
    });
    notifyListeners();
  }
}