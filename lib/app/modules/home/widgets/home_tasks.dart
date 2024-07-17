import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';
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
          Selector<HomeController, String>(
            selector: (context, controller) =>
                controller.selectedFilter.description,
            builder: (context, value, child) {
              return Text(value, style: context.titleStyle);
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: context
                .select<HomeController, List<TaskModel>>(
                  (controller) => controller.filteredTasks,
                )
                .map((task) => Task(model: task))
                .toList(),
          )
        ],
      ),
    );
  }
}
