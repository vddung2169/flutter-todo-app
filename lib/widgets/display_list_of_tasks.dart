import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/ultils/extensions.dart';
import 'package:todo_app/widgets/common_container.dart';
import 'package:todo_app/widgets/widgets.dart';

class DisplayListOfTasks extends StatelessWidget {
  const DisplayListOfTasks(
      {super.key, required this.tasks, this.isCompletedTasks = false});

  final List<Task> tasks;
  final bool isCompletedTasks;

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    final height =
        isCompletedTasks ? deviceSize.height * 0.2 : deviceSize.height * 0.3;
    final emptyTaskMessage = isCompletedTasks
        ? 'You have not completed any task yet'
        : 'You have no task to do';
    return CommonContainer(
      height: height,
      child: tasks.isEmpty
          ? Container(
              margin: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  emptyTaskMessage,
                  style: context.textTheme.headlineSmall,
                ),
              ),
            )
          : ListView.separated(
              shrinkWrap: true,
              itemCount: tasks.length,
              padding: const EdgeInsets.only(
                  top: 10, left: 16, bottom: 10, right: 16),
              itemBuilder: (ctx, index) {
                final task = tasks[index];
                return TaskTile(task: task);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 1.5,
                );
              },
            ),
    );
  }
}
