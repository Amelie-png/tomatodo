import 'package:tomatodo/models/story_points.dart';

enum Status {
  todo,
  inProgress,
  finalizing,
  completed
}

extension StatusLabel on Status {
  String get label {
    switch (this) {
      case Status.todo:
        return 'To Do';
      case Status.inProgress:
        return 'In Progress';
      case Status.finalizing:
        return 'Finalizing';
      case Status.completed:
        return 'Completed';
    }
  }
}

class Task {
  final String title;
  final String? description, taskCategory;
  final DateTime? deadline;
  final StoryPoints storyPoints;
  final Status status;

  const Task({ required this.title, 
    this.taskCategory,
    required this.storyPoints,
    this.deadline, 
    this.description, 
    this.status = Status.todo}
  );

  Task copyWith({
    String? title,
    String? taskCategory,
    String? description,
    DateTime? deadline,
    StoryPoints? storyPoints,
    Status? status,
  }) {
    return Task(
      title: title ?? this.title,
      taskCategory: taskCategory ?? this.taskCategory,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
      storyPoints: storyPoints ?? this.storyPoints,
      status: status ?? this.status,
    );
  }
}