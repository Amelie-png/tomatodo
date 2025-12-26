import 'package:flutter/material.dart';
import 'package:tomatodo/models/story_points.dart';
import '../models/task.dart';
import '../widgets/task_list_col.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  late List<Task> todoTasks;
  late List<Task> inProgressTasks;
  late List<Task> finalizingTasks;
  late List<Task> completedTasks;

  @override
  void initState() {
    super.initState();

    // Create tasks ONCE here
    todoTasks = [
      Task(title: 'Design UI', taskCategory: 'CS', storyPoints: StoryPoints()),
      Task(title: 'Fix lamp', taskCategory: 'Home', storyPoints: StoryPoints()),
    ];

    inProgressTasks = [
      Task(
        title: 'Finish A2',
        taskCategory: 'Math',
        storyPoints: StoryPoints(),
      ),
    ];

    finalizingTasks = [
      Task(title: '倒垃圾', taskCategory: 'Home', storyPoints: StoryPoints()),
    ];

    completedTasks = [
      Task(title: '吃饭', taskCategory: 'Home', storyPoints: StoryPoints()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: TaskListColumn(title: 'TODO', tasks: todoTasks),
          ),
          Expanded(
            child: TaskListColumn(title: 'IN PROGRESS', tasks: inProgressTasks),
          ),
          Expanded(
            child: TaskListColumn(title: 'FINALIZING', tasks: finalizingTasks),
          ),
          Expanded(
            child: TaskListColumn(title: 'COMPLETED', tasks: completedTasks),
          ),
        ],
      ),
    );
  }
}
