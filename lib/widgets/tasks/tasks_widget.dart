import 'package:flutter/material.dart';
import 'package:todo_app/widgets/tasks/tasks_widget_model.dart';

class TasksWidget extends StatefulWidget {
  static const id = 'tasks_screen';

  const TasksWidget({Key? key}) : super(key: key);

  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  late TasksWidgetModel _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_model == null) {
      final groupKey = ModalRoute
          .of(context)!
          .settings
          .arguments as int;
      _model = TasksWidgetModel(groupKey: groupKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
