import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/modules/home/widgets/task.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({super.key});

  @override
  Widget build(BuildContext context) {
    // Since this is the latest widget, we wrap everything in Expanded so it occupies the rest
    // of the screen
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text('TODAY\'S TASKS', style: context.titleStyle),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
            ],
          )
        ],
      ),
    );
  }
}
