import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:todo_list_provider/app/modules/tasks/task_create_controller.dart';
import 'package:todo_list_provider/app/modules/tasks/widgets/calendar_button.dart';

class TaskCreatePage extends StatelessWidget {
  final TaskCreateController _controller;
  final _formKey = GlobalKey<FormState>();

  TaskCreatePage({super.key, required TaskCreateController controller})
      : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.close, color: Colors.black),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: context.primaryColor,
        onPressed: () {},
        label: Text(
          'Save task',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Create new task',
                  style: context.titleStyle.copyWith(fontSize: 20),
                ),
              ),
              const SizedBox(height: 30),
              TodoListField(label: ''),
              const SizedBox(height: 20),
              CalendarButton(),
            ],
          ),
        ),
      ),
    );
  }
}
