import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/domain/entity/group.dart';
import 'package:todo_app/domain/entity/task.dart';
import 'package:todo_app/widgets/tasks/tasks_widget.dart';

class GroupsWidgetModel extends ChangeNotifier {
  GroupsWidgetModel() {
    _setup();
  }

  var _groups = <Group>[];

  List<Group> get groups => _groups.toList();

  void _setup() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('groups_box');
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    await Hive.openBox<Task>('tasks_box');
    _groups = box.values.toList();
    notifyListeners();
    box.listenable().addListener(() {
      _groups = box.values.toList();
      notifyListeners();
    });
  }

  void deleteGroup(int index) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('groups_box');
    await box.getAt(index)?.tasks?.deleteAllFromHive();
    await box.deleteAt(index);
  }

  void showTasks(BuildContext context, int index) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('groups_box');
    final groupKey = box.keyAt(index);

    Navigator.of(context).pushNamed(TasksWidget.id, arguments: groupKey);
  }
}

class GroupsWidgetModelProvider extends InheritedNotifier {
  final GroupsWidgetModel model;

  const GroupsWidgetModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
    key: key,
    notifier: model,
    child: child,
  );

  static GroupsWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GroupsWidgetModelProvider>();
  }

  static GroupsWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<GroupsWidgetModelProvider>()
        ?.widget;
    return widget is GroupsWidgetModelProvider ? widget : null;
  }
}
