import 'package:flutter/material.dart';
import 'package:tomatodo/screens/create_task.dart';
import '../models/task.dart';
import '../widgets/task_list_col.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final Map<Status, List<Task>> columns = {
    Status.todo: [],
    Status.inProgress: [],
    Status.finalizing: [],
    Status.completed: [],
  };

  void _moveTask(Task task, Status newStatus) {
    setState(() {
      columns.forEach((_, list) => list.remove(task));
      columns[newStatus]!.add(task.copyWith(status: newStatus));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Task List'),
      ),
      body: Row(
        children: Status.values.map((status) {
          return Expanded(
            child: TaskListColumn(
              status: status,
              tasks: columns[status]!,
              onTaskDropped: _moveTask,
            ),
          );
        }).toList(),
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
    // Navigator.pop on the CreateTask Screen.
    final result = await Navigator.push(
      context,
      // Create the CreateTask in the next step.
      MaterialPageRoute<Task>(builder: (context) => const CreateTask()),
    );

    if (!context.mounted) return;

    if (result != null) {
      setState(() {
        columns[result.status]!.add(result);
      });
    }
  }
}
