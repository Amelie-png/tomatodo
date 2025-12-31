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
  final List<Task> _tasks = [];

  //Draggable
  void _moveTask(Task task, Status newStatus) {
    setState(() {
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index == -1) return;
      _tasks[index] = task.copyWith(status: newStatus);
    });
  }

  //From create task screen
  void _saveTask(Task task) {
    setState(() {
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = task;
      } else {
        _tasks.add(task);
      }
    });
  }
  void _editTask(Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            CreateTask(mode: TaskMode.edit, task: task, onSave: _saveTask),
      ),
    );
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
              tasks: _tasks.where((t) => t.status == status).toList(),
              onTaskDropped: _moveTask,
              onEdit: _editTask,
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  CreateTask(mode: TaskMode.create, onSave: _saveTask),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
