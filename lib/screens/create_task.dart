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

typedef MenuEntry = DropdownMenuEntry<Status>;

class _CreateTaskState extends State<CreateTask> {
  //subject
  final subjectController = TextEditingController();

  //story points
  double _currentTimePoints = 3;
  double _currentComplexityPoints = 3;
  double _currentUrgencyPoints = 3;

  //status
  static final List<MenuEntry> dropdownEntries = Status.values
      .map((status) => MenuEntry(value: status, label: status.label))
      .toList();

  Status _dropdownValue = Status.todo;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    subjectController.dispose();
    super.dispose();
  }

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
          TextField(
            controller: subjectController,
            decoration: InputDecoration(
              labelText: 'Subject',
              hintText: 'Enter task subject',
              border: OutlineInputBorder(),
            ),
          ),
          const Text('Status'),
          DropdownMenu<Status>(
            initialSelection: _dropdownValue,
            onSelected: (Status? value) {
              // This is called when the user selects an item.
              setState(() {
                _dropdownValue = value!;
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
                    Task result = Task(
                      title: subjectController.text,
                      storyPoints: StoryPoints(
                        timePoints: _currentTimePoints.round(),
                        complexityPoints: _currentComplexityPoints.round(),
                        urgencyPoints: _currentUrgencyPoints.round(),
                      ),
                      status: _dropdownValue,
                    );
                    Navigator.pop(context, result);
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
