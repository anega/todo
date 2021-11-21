import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 2)
class Task extends HiveObject {
  @HiveField(0)
  String text;
  @HiveField(1)
  bool done;

  Task({
    required this.text,
    required this.done,
  });
}
