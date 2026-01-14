import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback? onEdit;

  const TaskTile({super.key, required this.task, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Draggable<Task>(
      data: task,
      feedback: Material(child: Opacity(opacity: 0.9, child: _tileContent())),
      childWhenDragging: const SizedBox.shrink(),
      child: _tileContent(),
    );
  }

  Widget _tileContent() {
    return Container(
      height: 50,
      width: 200,
      color: task.taskCategory.color,
      child: ListTile(
        title: Text(task.title),
        subtitle: Text(task.taskCategory.toString()), // Main content
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: onEdit,
        ),
      ),
    );
  }
}
