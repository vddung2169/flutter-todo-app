import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/ultils/extensions.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final style = context.textTheme;
    return Row(
      children: [
        Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.person),
            )),
        const Gap(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(task.title), Text(task.time)],
          ),
        ),
        Checkbox(value: task.isCompleted, onChanged: (value) {})
      ],
    );
  }
}
