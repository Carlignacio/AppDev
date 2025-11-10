import 'package:flutter/material.dart';
import '../models/progress.dart';
import '../services/database_service.dart';

class ProgressController extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();
  List<Progress> _userProgress = [];
  bool _isLoading = false;

  List<Progress> get userProgress => _userProgress;
  bool get isLoading => _isLoading;

  Future<void> loadUserProgress(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _userProgress = await _db.getUserProgress(userId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> markLessonComplete(
    String userId,
    String courseId,
    String lessonId,
  ) async {
    var progress = await _db.getProgress(userId, courseId);
    
    if (progress == null) {
      progress = Progress(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        courseId: courseId,
        completedLessonIds: [lessonId],
        quizScores: {},
        lastAccessedAt: DateTime.now(),
      );
    } else {
      if (!progress.completedLessonIds.contains(lessonId)) {
        progress = Progress(
          id: progress.id,
          userId: progress.userId,
          courseId: progress.courseId,
          completedLessonIds: [...progress.completedLessonIds, lessonId],
          quizScores: progress.quizScores,
          completionPercentage: progress.completionPercentage,
          lastAccessedAt: DateTime.now(),
        );
      }
    }

    await _db.updateProgress(progress);
    await loadUserProgress(userId);
  }

  Future<void> saveQuizScore(
    String userId,
    String courseId,
    String quizId,
    int score,
  ) async {
    var progress = await _db.getProgress(userId, courseId);
    
    if (progress != null) {
      final updatedScores = {...progress.quizScores, quizId: score};
      progress = Progress(
        id: progress.id,
        userId: progress.userId,
        courseId: progress.courseId,
        completedLessonIds: progress.completedLessonIds,
        quizScores: updatedScores,
        completionPercentage: progress.completionPercentage,
        lastAccessedAt: DateTime.now(),
      );
      await _db.updateProgress(progress);
      await loadUserProgress(userId);
    }
  }
}