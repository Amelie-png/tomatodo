import 'package:flutter/material.dart';
import 'package:tomatodo/widgets/task_tile.dart';
import '../models/task.dart';

class TaskListColumn extends StatefulWidget {
  final Status status;
  final List<Task> tasks;
  final void Function(Task task, Status newStatus) onTaskDropped;
  final void Function(Task task)? onEdit;

  const TaskListColumn({
    super.key,
    required this.status,
    required this.tasks,
    required this.onTaskDropped,
    this.onEdit,
  });

  @override
  State<TaskListColumn> createState() => _TaskListColumnState();
}

class _TaskListColumnState extends State<TaskListColumn> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return DragTarget<Task>(
      onWillAcceptWithDetails: (_) {
        setState(() => _isHovered = true);
        return true;
      },
      onLeave: (_) {
        setState(() => _isHovered = false);
      },
      onAcceptWithDetails: (detail) {
        setState(() => _isHovered = false);
        widget.onTaskDropped(detail.data, widget.status);
      },
      builder: (context, candidateData, rejectedData) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _isHovered
                ? Colors.blue.withValues(alpha: 0.1)
                : Colors.transparent,
          ),
          child: Column(
            children: [
              Text(widget.status.label),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: widget.tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TaskTile(
                      task: widget.tasks[index],
                      onEdit: widget.onEdit == null
                          ? null
                          : () => widget.onEdit!(widget.tasks[index]),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
