import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  final String id;
  final String title;
  final String description;
  final String? thumbnailUrl;
  final String category;
  final int duration; // in minutes
  final String level; // beginner, intermediate, advanced
  final List<String> lessonIds;
  final int enrolledCount;
  final double rating;

  Course({
    required this.id,
    required this.title,
    required this.description,
    this.thumbnailUrl,
    required this.category,
    required this.duration,
    this.level = 'beginner',
    required this.lessonIds,
    this.enrolledCount = 0,
    this.rating = 0.0,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      thumbnailUrl: json['thumbnailUrl'],
      category: json['category'],
      duration: json['duration'],
      level: json['level'],
      lessonIds: List<String>.from(json['lessonIds'] ?? []),
      enrolledCount: json['enrolledCount'] ?? 0,
      rating: (json['rating'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'thumbnailUrl': thumbnailUrl,
      'category': category,
      'duration': duration,
      'level': level,
      'lessonIds': lessonIds,
      'enrolledCount': enrolledCount,
      'rating': rating,
    };
  }

  static fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {}
}