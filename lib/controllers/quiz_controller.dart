import 'package:flutter/material.dart';
import '../models/quiz.dart';
import '../models/question.dart';
import '../services/database_service.dart';

class QuizController extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();
  Quiz? _currentQuiz;
  int _currentQuestionIndex = 0;
  Map<int, int> _userAnswers = {};
  int _score = 0;
  bool _isQuizCompleted = false;

  Quiz? get currentQuiz => _currentQuiz;
  int get currentQuestionIndex => _currentQuestionIndex;
  Question? get currentQuestion =>
      _currentQuiz?.questions[_currentQuestionIndex];
  Map<int, int> get userAnswers => _userAnswers;
  int get score => _score;
  bool get isQuizCompleted => _isQuizCompleted;

  Future<void> loadQuiz(String quizId) async {
    _currentQuiz = await _db.getQuiz(quizId);
    _currentQuestionIndex = 0;
    _userAnswers.clear();
    _score = 0;
    _isQuizCompleted = false;
    notifyListeners();
  }

  void answerQuestion(int answerIndex) {
    _userAnswers[_currentQuestionIndex] = answerIndex;
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < (_currentQuiz?.questions.length ?? 0) - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  void submitQuiz() {
    _score = 0;
    _userAnswers.forEach((questionIndex, answerIndex) {
      final question = _currentQuiz?.questions[questionIndex];
      if (question != null && question.correctAnswerIndex == answerIndex) {
        _score += question.points;
      }
    });
    _isQuizCompleted = true;
    notifyListeners();
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _userAnswers.clear();
    _score = 0;
    _isQuizCompleted = false;
    notifyListeners();
  }
}