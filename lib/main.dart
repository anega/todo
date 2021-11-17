import 'package:flutter/material.dart';
import 'package:todo_app/widgets/groups/groups_widget.dart';

void main() {
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
        GroupsWidget.id: (context) => GroupsWidget()
      },
    );
  }
}
