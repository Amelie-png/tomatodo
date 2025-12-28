import 'package:flutter/material.dart';
import 'package:tomatodo/screens/create_task.dart';
import '../models/story_points.dart';
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
    todoTasks = [];

    inProgressTasks = [];

    finalizingTasks = [];

    completedTasks = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Task List'),
      ),
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
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToCreateTask(context);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future<void> _navigateToCreateTask(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Create Task Screen.
    final result = await Navigator.push(
      context,
      // Create the CreateTask in the next step.
      MaterialPageRoute<Task>(builder: (context) => const CreateTask()),
    );

    if (!context.mounted) return;

    if (result != null) {
      setState(() {
        switch (result.status) {
          case Status.todo:
            todoTasks.add(result);
          case Status.inProgress:
            inProgressTasks.add(result);
          case Status.finalizing:
            finalizingTasks.add(result);
          case Status.completed:
            completedTasks.add(result);
        }
      });
    }
  }
}
