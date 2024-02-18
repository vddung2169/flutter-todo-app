import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/data/models/task.dart';
import 'package:todo_app/ultils/extensions.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme;
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Text(task.title,
              style: style.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          Text(task.time, style: style.titleMedium),
          const Gap(16),
          Visibility(
              visible: !task.isCompleted,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Task to be completed on ${task.date}')],
              )),
          const Gap(16),
          const Divider(
            thickness: 1.5,
          ),
          const Gap(16),
          Text(
            task.note.isEmpty
                ? 'There is no addition note for this task'
                : task.note,
          ),
          const Gap(16),
          Visibility(
            visible: task.isCompleted,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Task completed'),
                Icon(
                  Icons.check_box,
                  color: Colors.green,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
