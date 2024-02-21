import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/ultils/ultils.dart';
import 'package:todo_app/widgets/widgets.dart';

class TodayTask extends ConsumerStatefulWidget {
  static TodayTask builder(BuildContext context, GoRouterState state) =>
      const TodayTask();

  const TodayTask({super.key});

  @override
  ConsumerState<TodayTask> createState() => _TodayTaskState();
}

class _TodayTaskState extends ConsumerState<TodayTask> {
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
                          'Today Task',
                          style: context.textTheme.headlineMedium,
                        ),
                        const Gap(10),
                        DisplayListOfTasks(
                          tasks: _todayTasks(taskState.tasks, ref),
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
