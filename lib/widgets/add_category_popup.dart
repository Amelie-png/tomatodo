import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../models/task_category.dart';

class AddCategoryPopup extends StatefulWidget {
  final List<TaskCategory> existingCategories;

  const AddCategoryPopup({super.key, required this.existingCategories});

  @override
  State<AddCategoryPopup> createState() => _AddCategoryPopupState();
}

class _AddCategoryPopupState extends State<AddCategoryPopup> {
  final _controller = TextEditingController();
  Color _color = const Color.fromARGB(255, 190, 235, 220);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _isDuplicate(String title) {
    return widget.existingCategories.any(
      (c) => c.category.toLowerCase() == title.toLowerCase(),
    );
  }

  void _openColorPicker() {
    showDialog(
      context: context,
      builder: (_) {
        Color temp = _color;
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: temp,
              onColorChanged: (c) => temp = c,
              enableAlpha: false,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() => _color = temp);
                Navigator.pop(context);
              },
              child: const Text('Select'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Category'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Category Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              GestureDetector(
                onTap: _openColorPicker,
                child: CircleAvatar(backgroundColor: _color, radius: 16),
              ),
              const SizedBox(width: 12),
              const Text('Category color'),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final title = _controller.text.trim();
            if (title.isEmpty) return;
            if (_isDuplicate(title)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Category already exists')),
              );
              return;
            }

            Navigator.pop(
              context,
              TaskCategory(category: title, color: _color),
            );
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

// Color tempColor = _selectedColor;

//         return StatefulBuilder(
//           builder: (context, setDialogState) {
//             return AlertDialog(
//               title: const Text('Add New Category'),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextField(
//                     controller: _newCategoryController,
//                     decoration: const InputDecoration(
//                       labelText: 'Category Title',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: [
//                       GestureDetector(
//                         onTap: () async {
//                           await showDialog(
//                             context: context,
//                             builder: (_) => StatefulBuilder(
//                               builder: (context, setPickerState) {
//                                 return AlertDialog(
//                                   content: ColorPicker(
//                                     pickerColor: tempColor,
//                                     onColorChanged: (c) {
//                                       setPickerState(() => tempColor = c);
//                                     },
//                                     enableAlpha: false,
//                                   ),
//                                   actions: [
//                                     TextButton(
//                                       onPressed: () {
//                                         setDialogState(() {
//                                           _selectedColor = tempColor;
//                                         });
//                                         Navigator.pop(context);
//                                       },
//                                       child: const Text('Select'),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             ),
//                           );
//                         },
//                         child: CircleAvatar(
//                           backgroundColor: tempColor,
//                           radius: 16,
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       const Text('Category color'),
//                     ],
//                   ),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text('Cancel'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     final title = _newCategoryController.text.trim();
//                     if (title.isEmpty) return;
//                     if (_categories.any(
//                       (c) => c.category.toLowerCase() == title.toLowerCase(),
//                     )) {
//                       return;
//                     }

//                     Navigator.pop(
//                       context,
//                       TaskCategory(category: title, color: tempColor),
//                     );
//                   },
//                   child: const Text('Save'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
