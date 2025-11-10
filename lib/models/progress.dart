class Progress {
  final String id;
  final String userId;
  final String courseId;
  final List<String> completedLessonIds;
  final Map<String, int> quizScores; // quizId -> score
  final double completionPercentage;
  final DateTime lastAccessedAt;

  Progress({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.completedLessonIds,
    required this.quizScores,
    this.completionPercentage = 0.0,
    required this.lastAccessedAt,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      id: json['id'],
      userId: json['userId'],
      courseId: json['courseId'],
      completedLessonIds: List<String>.from(json['completedLessonIds'] ?? []),
      quizScores: Map<String, int>.from(json['quizScores'] ?? {}),
      completionPercentage: (json['completionPercentage'] ?? 0.0).toDouble(),
      lastAccessedAt: DateTime.parse(json['lastAccessedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'courseId': courseId,
      'completedLessonIds': completedLessonIds,
      'quizScores': quizScores,
      'completionPercentage': completionPercentage,
      'lastAccessedAt': lastAccessedAt.toIso8601String(),
    };
  }
}