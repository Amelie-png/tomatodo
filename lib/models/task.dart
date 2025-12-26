import 'package:tomatodo/models/story_points.dart';

enum Status {
  todo,
  inProgress,
  finalizing,
  completed
}

class Task {
  final String title, taskCategory;
  final String? description;
  final DateTime? deadline;
  final StoryPoints storyPoints;
  final Status status;

  const Task({ required this.title, 
    required this.taskCategory,
    required this.storyPoints,
    this.deadline, 
    this.description, 
    this.status = Status.todo}
  );

  Task copyWith({
    String? title,
    String? taskList,
    String? description,
    DateTime? deadline,
    StoryPoints? storyPoints,
    Status? status,
  }) {
    return Task(
      title: title ?? this.title,
      taskCategory: taskList ?? this.taskCategory,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
      storyPoints: storyPoints ?? this.storyPoints,
      status: status ?? this.status,
    );
  }
}