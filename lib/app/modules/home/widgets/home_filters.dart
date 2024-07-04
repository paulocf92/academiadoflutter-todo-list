import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/total_tasks_model.dart';
import 'package:todo_list_provider/app/modules/home/widgets/todo_card_filter.dart';

class HomeFilters extends StatelessWidget {
  const HomeFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('FILTERS', style: context.titleStyle),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TodoCardFilter(
                label: 'TODAY',
                taskFilter: TaskFilterEnum.today,
                totalTasksModel:
                    TotalTasksModel(totalTasks: 20, totalTasksFinished: 10),
              ),
              TodoCardFilter(
                label: 'TOMORROW',
                taskFilter: TaskFilterEnum.tomorrow,
                totalTasksModel:
                    TotalTasksModel(totalTasks: 10, totalTasksFinished: 5),
              ),
              TodoCardFilter(
                label: 'WEEK',
                taskFilter: TaskFilterEnum.week,
                totalTasksModel:
                    TotalTasksModel(totalTasks: 10, totalTasksFinished: 5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
