import 'package:hive/hive.dart';
import 'package:todo_app/domain/entity/task.dart';

part 'group.g.dart';

@HiveType(typeId: 1)
class Group {
  @HiveField(0)
  final String name;

  @HiveField(1)
  HiveList? tasks;

  Group({required this.name});

  void addTask(Box<Task> box, Task task) {
    tasks ??= HiveList(box, objects: [task]);
  }
}