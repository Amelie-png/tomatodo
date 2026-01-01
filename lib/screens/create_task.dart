import 'package:flutter/material.dart';
import 'package:tomatodo/models/task_category.dart';
import 'package:tomatodo/widgets/add_category_popup.dart';
import 'package:tomatodo/widgets/task_points_slider.dart';
import 'package:uuid/uuid.dart';
import '../models/story_points.dart';
import '../models/task.dart';

class CreateTask extends StatefulWidget {
  final TaskMode mode;
  final Task? task;
  final ValueChanged<Task> onSave;
  final List<TaskCategory> taskCategories;
  final ValueChanged<List<TaskCategory>> onNewCategory;
  const CreateTask({
    super.key,
    required this.mode,
    this.task,
    required this.onSave,
    required this.taskCategories,
    required this.onNewCategory,
  });

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

typedef MenuEntry = DropdownMenuEntry<Status>;

enum TaskMode { create, edit }

class _CreateTaskState extends State<CreateTask> {
  late Task _draftTask;

  //subject
  late TextEditingController _titleController;
  bool get _isValid => _titleController.text.trim().isNotEmpty;

  //description
  late TextEditingController _descriptionController;

  //category
  late List<TaskCategory> _categories;
  int? _selectedIndex;
  Future<void> _addCategory() async {
    final TaskCategory? newCategory = await showDialog<TaskCategory>(
      context: context,
      builder: (_) => AddCategoryPopup(existingCategories: _categories),
    );

    if (newCategory != null) {
      setState(() => _categories.add(newCategory));
      widget.onNewCategory(List.unmodifiable(_categories));
    }
  }

  //deadline
  DateTime? _selectedDate;
  DateTime farFuture([int years = 30]) {
    final now = DateTime.now();
    return DateTime(now.year + years, now.month, now.day);
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: farFuture(),
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  //story points
  double _currentTimePoints = 3;
  double _currentComplexityPoints = 3;
  double _currentUrgencyPoints = 3;

  //status
  static final List<MenuEntry> dropdownEntries = Status.values
      .map((status) => MenuEntry(value: status, label: status.label))
      .toList();
  Status _dropdownValue = Status.todo;

  //save
  void _saveTask() {
    // Navigate to task list with task
    final result = _draftTask.copyWith(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      taskCategory: _selectedIndex == null
          ? _categories.first
          : _categories[_selectedIndex! + 1],
      storyPoints: StoryPoints(
        timePoints: _currentTimePoints.round(),
        complexityPoints: _currentComplexityPoints.round(),
        urgencyPoints: _currentUrgencyPoints.round(),
      ),
      status: _dropdownValue,
    );

    widget.onSave(result);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    _categories = List.from(widget.taskCategories);

    if (widget.mode == TaskMode.edit && widget.task != null) {
      _draftTask = widget.task!.copyWith();
    } else {
      _draftTask = Task(
        id: const Uuid().v4(),
        title: '',
        taskCategory: _categories[0],
        storyPoints: StoryPoints(),
        createdAt: DateTime.now(),
      );
    }

    _titleController = TextEditingController(text: _draftTask.title);
    _descriptionController = TextEditingController(
      text: _draftTask.description,
    );
    _dropdownValue = _draftTask.status;
    _currentTimePoints = _draftTask.storyPoints.timePoints.toDouble();
    _currentComplexityPoints = _draftTask.storyPoints.complexityPoints
        .toDouble();
    _currentUrgencyPoints = _draftTask.storyPoints.urgencyPoints.toDouble();

    if (widget.mode == TaskMode.edit && widget.task?.taskCategory != null) {
      final index = _categories.indexWhere(
        (c) => c == widget.task!.taskCategory,
      );
      if (index > 0) {
        _selectedIndex = index - 1; // No category is hidden
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.mode == TaskMode.edit;
    final visibleCategories = _categories.skip(1).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(isEdit ? 'Edit Task' : 'Create Task'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            TextField(
              controller: _titleController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: 'Enter task title',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Describe task details',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
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
            Row(
              children: [
                Expanded(child: const Text('Task Category (optional)')),
                IconButton(onPressed: _addCategory, icon: Icon(Icons.add)),
              ],
            ),
            Wrap(
              spacing: 5.0,
              children: List<Widget>.generate(visibleCategories.length, (
                int index,
              ) {
                return ChoiceChip(
                  label: Text(visibleCategories[index].category),
                  selected: _selectedIndex == index,
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedIndex = selected ? index : null;
                    });
                  },
                );
              }).toList(),
            ),
            Text('Task deadline'),
            OutlinedButton(
              onPressed: _selectDate,
              child: Text(
                _selectedDate != null
                    ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                    : 'No date selected',
              ),
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
                    onPressed: _isValid ? _saveTask : null,
                    child: Text(isEdit ? 'Save' : 'Create'),
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
      ),
    );
  }
}
