import 'dart:ui';

class TaskCategory {
  final String category;
  final Color color;

  const TaskCategory({
    required this.category,
    required this.color,
  });

  TaskCategory copyWith({String? category, Color? color}) {
    return TaskCategory(
      category: category ?? this.category,
      color: color ?? this.color,
    );
  }
}
