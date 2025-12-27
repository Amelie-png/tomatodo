import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:tomatodo/screens/task_list.dart';
import 'package:tomatodo/widgets/task_points_slider.dart';
import '../models/story_points.dart';
import '../models/task.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

const List<String> list = <String>[
  'Todo',
  'In Progress',
  'Finalized',
  'Completed',
];
typedef MenuEntry = DropdownMenuEntry<String>;

class _CreateTaskState extends State<CreateTask> {
  static final List<MenuEntry> dropdownEntries =
      UnmodifiableListView<MenuEntry>(
        list.map<MenuEntry>(
          (String name) => MenuEntry(value: name, label: name),
        ),
      );
  String dropdownValue = list.first;

  double _currentTimePoints = 3;
  double _currentComplexityPoints = 3;
  double _currentUrgencyPoints = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Create task'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16,
        children: [
          const TextField(
            decoration: InputDecoration(
              labelText: 'Subject',
              hintText: 'Enter task subject',
              border: OutlineInputBorder(),
            ),
          ),
          const Text('Status'),
          DropdownMenu<String>(
            initialSelection: list.first,
            onSelected: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
            },
            dropdownMenuEntries: dropdownEntries,
          ),
          const Text('Story Points'),
          TaskPointsSlider(
            title: 'Time needed',
            currentValue: _currentTimePoints,
            onChanged: (double value) {
              setState(() {
                _currentTimePoints = value;
              });
            },
          ),
          TaskPointsSlider(
            title: 'Task complexity',
            currentValue: _currentComplexityPoints,
            onChanged: (double value) {
              setState(() {
                _currentComplexityPoints = value;
              });
            },
          ),
          TaskPointsSlider(
            title: 'Task urgency',
            currentValue: _currentUrgencyPoints,
            onChanged: (double value) {
              setState(() {
                _currentUrgencyPoints = value;
              });
            },
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  child: const Text('Save'),
                  onPressed: () {
                    // Navigate to task list with task
                    Navigator.pop(context);
                  },
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    // Navigate to task list without task
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
