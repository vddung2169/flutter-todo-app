import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/config/routes/route_location.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/ultils/ultils.dart';
import 'package:todo_app/widgets/widgets.dart';

class UpCommingTask extends ConsumerStatefulWidget {
  static UpCommingTask builder(BuildContext context, GoRouterState state) =>
      const UpCommingTask();

  const UpCommingTask({super.key});

  @override
  ConsumerState<UpCommingTask> createState() => _UpCommingTaskState();
}

class _UpCommingTaskState extends ConsumerState<UpCommingTask> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final taskState = ref.watch(taskProvider);
        final selectDate = ref.watch(dateProvider);
        return Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          children: [
                        Text(
                          'Up Comming Task (2 days)',
                          style: context.textTheme.headlineMedium,
                        ),
                        const Gap(10),
                        DisplayListOfTasks(
                          tasks: _upCommingTasks(taskState.tasks, selectDate),
                          isCompletedTasks: true,
                        ),
                      ]))
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  List<Task> _upCommingTasks(List<Task> tasks, DateTime selectedDate) {
    final List<Task> filteredTasks = [];
    final DateFormat formatter = DateFormat.yMMMd();

    for (var task in tasks) {
      final deadline = formatter.parse(task.date);

      final differenceInDays = deadline.difference(selectedDate).inDays;

      if (differenceInDays < 2 && differenceInDays > 0) {
        filteredTasks.add(task);
      }
    }
    return filteredTasks;
  }

  List<Task> _todayTasks(List<Task> tasks, WidgetRef ref) {
    final List<Task> filteredTasks = [];
    final DateTime today = DateTime.now(); // Lấy ngày hôm nay
    final DateFormat formatter = DateFormat.yMMMd();

    for (var task in tasks) {
      final DateTime taskDate = formatter.parse(task.date);

      // So sánh ngày của task với ngày hôm nay
      if (taskDate.year == today.year &&
          taskDate.month == today.month &&
          taskDate.day == today.day &&
          !task.isCompleted) {
        filteredTasks.add(task);
      }
    }

    return filteredTasks;
  }
}
