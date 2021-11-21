import 'package:flutter/material.dart';
import 'package:todo_app/widgets/task_form/task_form_widget_model.dart';

class TaskFormWidget extends StatefulWidget {
  static const id = 'task_form_screen';

  const TaskFormWidget({Key? key}) : super(key: key);

  @override
  _TaskFormWidgetState createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  TaskFormWidgetModel? _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_model == null) {
      final groupKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = TaskFormWidgetModel(groupKey: groupKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TaskFormWidgetModelProvider(
      model: _model!,
      child: const _TaskFormWidgetBody(),
    );
  }
}

class _TaskFormWidgetBody extends StatelessWidget {
  const _TaskFormWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New task')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: _TaskNameWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => TaskFormWidgetModelProvider.read(context)?.model.saveTask(context),
        child: const Icon(Icons.done),
      ),
    );
  }
}

class _TaskNameWidget extends StatelessWidget {
  const _TaskNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TaskFormWidgetModelProvider.read(context)?.model;
    return TextField(
      onChanged: (value) => model?.taskText = value,
      onEditingComplete: () => model?.saveTask(context),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        label: Text('New task name'),
      ),
    );
  }
}
