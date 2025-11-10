import 'package:elearning_app/models/question.dart';

class Quiz {
  final String id;
  final String courseId;
  final String title;
  final List<Question> questions;
  final int passingScore;
  final int timeLimit; // in minutes

  Quiz({
    required this.id,
    required this.courseId,
    required this.title,
    required this.questions,
    this.passingScore = 70,
    this.timeLimit = 30,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      courseId: json['courseId'],
      title: json['title'],
      questions: (json['questions'] as List)
          .map((q) => Question.fromJson(q))
          .toList(),
      passingScore: json['passingScore'] ?? 70,
      timeLimit: json['timeLimit'] ?? 30,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'title': title,
      'questions': questions.map((q) => q.toJson()).toList(),
      'passingScore': passingScore,
      'timeLimit': timeLimit,
    };
  }
}