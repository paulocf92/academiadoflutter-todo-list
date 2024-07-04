import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/total_tasks_model.dart';

class TodoCardFilter extends StatelessWidget {
  final String label;
  final TaskFilterEnum taskFilter;
  final TotalTasksModel? totalTasksModel;

  const TodoCardFilter(
      {super.key,
      required this.label,
      required this.taskFilter,
      this.totalTasksModel});

  double _getPercentFinished() {
    final total = totalTasksModel?.totalTasks ?? 0;
    final totalFinished = totalTasksModel?.totalTasksFinished ?? 0.1;

    if (total == 0.0) {
      return 0.0;
    }

    final percent = (totalFinished * 100) / total;
    return percent / 100;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 120,
        maxWidth: 170,
      ),
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.primaryColor,
        border: Border.all(width: 1, color: Colors.grey.withOpacity(.8)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${totalTasksModel?.totalTasks ?? 0} TASKS',
            style:
                context.titleStyle.copyWith(fontSize: 10, color: Colors.white),
          ),
          Text(
            label,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween(
              begin: 0.0,
              end: _getPercentFinished(),
            ),
            duration: const Duration(seconds: 1),
            builder: (context, value, child) {
              return LinearProgressIndicator(
                backgroundColor: context.primaryColorLight,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                value: value,
              );
            },
          ),
        ],
      ),
    );
  }
}
