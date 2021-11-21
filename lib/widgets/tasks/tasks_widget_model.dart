import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/domain/entity/group.dart';
import 'package:todo_app/widgets/task_form/task_form_widget.dart';

class TasksWidgetModel extends ChangeNotifier {
  final int groupKey;
  late final Future<Box<Group>> _groupBox;
  Group? _group;

  Group? get group => _group;

  TasksWidgetModel({required this.groupKey}) {
    _setup();
  }

  void _setup() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    _groupBox = Hive.openBox<Group>('groups_box');
    _loadGroup();
  }

  void _loadGroup() async {
    final box = await _groupBox;
    _group = box.get(groupKey);
    notifyListeners();
  }

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed(TaskFormWidget.id, arguments: groupKey);
  }
}

class TasksWidgetModelProvider extends InheritedNotifier {
  final TasksWidgetModel model;

  const TasksWidgetModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );

  static TasksWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TasksWidgetModelProvider>();
  }

  static TasksWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TasksWidgetModelProvider>()
        ?.widget;
    return widget is TasksWidgetModelProvider ? widget : null;
  }
}
