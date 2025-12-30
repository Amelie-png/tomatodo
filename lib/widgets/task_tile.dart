import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({super.key, required this.task});

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
      color: const Color.fromARGB(255, 190, 235, 220),
      child: ListTile(
        title: Text(task.title), // Main content
        trailing: Icon(Icons.more_vert), // The trailing icon
        onTap: () {
          // Handle the tap event for the entire tile
        },
      ),
    );
  }
}
