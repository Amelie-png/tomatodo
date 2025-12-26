import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskListColumn extends StatelessWidget {
  final String title;
  final List<Task> tasks;

  const TaskListColumn({super.key, required this.title, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                color: const Color.fromARGB(255, 114, 157, 255),
                child: Center(child: Text(tasks[index].title)),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ),
      ],
    );
  }
}
