import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/ultils/extensions.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task, this.onCompleted});

  final Task task;

  final Function(bool?)? onCompleted;

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme;
    final textDecoration =
        task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none;
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
            children: [
              Text(
                task.title,
                style: style.titleMedium?.copyWith(
                  decoration: textDecoration,
                ),
              ),
              Text(task.time)
            ],
          ),
        ),
        Checkbox(value: task.isCompleted, onChanged: onCompleted)
      ],
    );
  }
}
