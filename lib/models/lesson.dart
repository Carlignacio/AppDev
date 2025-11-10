class Lesson {
  final String id;
  final String courseId;
  final String title;
  final String content;
  final String? videoUrl;
  final int order;
  final int duration; // in minutes
  final String type; // 'video', 'text', 'interactive'

  Lesson({
    required this.id,
    required this.courseId,
    required this.title,
    required this.content,
    this.videoUrl,
    required this.order,
    required this.duration,
    this.type = 'text',
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      courseId: json['courseId'],
      title: json['title'],
      content: json['content'],
      videoUrl: json['videoUrl'],
      order: json['order'],
      duration: json['duration'],
      type: json['type'] ?? 'text',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'title': title,
      'content': content,
      'videoUrl': videoUrl,
      'order': order,
      'duration': duration,
      'type': type,
    };
  }
}