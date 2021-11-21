import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/widgets/group_form/group_form_widget.dart';
import 'package:todo_app/widgets/groups/groups_widget_model.dart';
import 'package:todo_app/widgets/tasks/tasks_widget.dart';

class GroupsWidget extends StatefulWidget {
  static const id = 'groups_screen';

  const GroupsWidget({Key? key}) : super(key: key);

  @override
  State<GroupsWidget> createState() => _GroupsWidgetState();
}

class _GroupsWidgetState extends State<GroupsWidget> {
  final _model = GroupsWidgetModel();

  @override
  Widget build(BuildContext context) {
    return GroupsWidgetModelProvider(
      model: _model,
      child: const _GroupsWidgetBody(),
    );
  }
}

class _GroupsWidgetBody extends StatelessWidget {
  const _GroupsWidgetBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Groups')),
      body: _GroupList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(GroupFormWidget.id);
        },
      ),
    );
  }
}

class _GroupList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: GroupsWidgetModelProvider
          .watch(context)
          ?.model
          .groups
          .length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return _GroupListRowWidget(
          indexInList: index,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(height: 1);
      },
    );
  }
}

class _GroupListRowWidget extends StatelessWidget {
  final int indexInList;

  const _GroupListRowWidget({
    Key? key,
    required this.indexInList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final group = GroupsWidgetModelProvider
        .read(context)!
        .model
        .groups[indexInList];
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) =>
                GroupsWidgetModelProvider.read(context)!.model.deleteGroup(
                    indexInList),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
          title: Text(group.name),
          trailing: const Icon(Icons.chevron_right),
          onTap: () =>
              GroupsWidgetModelProvider
                  .read(context)
                  ?.model
                  .showTasks(context, indexInList),
      ),
    );
  }
}
