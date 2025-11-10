import 'package:flutter/material.dart';
import '../models/course.dart';
import '../models/lesson.dart';
import '../services/database_service.dart';

class CourseController extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();
  List<Course> _courses = [];
  List<Lesson> _lessons = [];
  bool _isLoading = false;

  List<Course> get courses => _courses;
  List<Lesson> get lessons => _lessons;
  bool get isLoading => _isLoading;

  Future<void> loadCourses() async {
    _isLoading = true;
    notifyListeners();

    _db.getCourses().listen((courses) {
      _courses = courses;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> loadLessons(String courseId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _lessons = await _db.getLessons(courseId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Course?> getCourseById(String courseId) async {
    return await _db.getCourse(courseId);
  }

  Future<void> enrollCourse(String courseId) async {
    // Implementation for enrolling in a course
    final course = await _db.getCourse(courseId);
    if (course != null) {
      await _db.updateCourse(courseId, {
        'enrolledCount': course.enrolledCount + 1,
      });
      await loadCourses();
    }
  }
}