import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/widgets/group_form/group_form_widget.dart';
import 'package:todo_app/widgets/groups/groups_widget.dart';
import 'package:todo_app/widgets/tasks/tasks_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: GroupsWidget.id,
      routes: {
        GroupsWidget.id: (context) => const GroupsWidget(),
        GroupFormWidget.id: (context) => const GroupFormWidget(),
        TasksWidget.id: (context) => const TasksWidget(),
      },
    );
  }
}
