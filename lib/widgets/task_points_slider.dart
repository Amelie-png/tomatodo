import 'package:flutter/material.dart';

class TaskPointsSlider extends StatelessWidget {
  final String title;
  final double currentValue;
  final ValueChanged<double> onChanged;

  const TaskPointsSlider({
    super.key,
    required this.title,
    required this.currentValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        Slider(
          year2023: false,
          value: currentValue,
          max: 5,
          min: 1,
          divisions: 4,
          label: currentValue.round().toString(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
