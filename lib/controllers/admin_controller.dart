import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/course.dart';
import '../services/database_service.dart';

class AdminController extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();
  List<User> _users = [];
  Map<String, dynamic> _analytics = {};
  bool _isLoading = false;

  List<User> get users => _users;
  Map<String, dynamic> get analytics => _analytics;
  bool get isLoading => _isLoading;

  Future<void> loadUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      _users = await _db.getAllUsers();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadAnalytics() async {
    _isLoading = true;
    notifyListeners();

    try {
      _analytics = await _db.getAnalytics();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createCourse(Course course) async {
    await _db.createCourse(course);
    notifyListeners();
  }

  Future<void> updateCourse(String courseId, Map<String, dynamic> data) async {
    await _db.updateCourse(courseId, data);
    notifyListeners();
  }

  Future<void> deleteCourse(String courseId) async {
    await _db.deleteCourse(courseId);
    notifyListeners();
  }
}