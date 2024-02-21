import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/config/routes/route_location.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/ultils/ultils.dart';
import 'package:todo_app/widgets/widgets.dart';

class CompletedTask extends ConsumerStatefulWidget {
  static CompletedTask builder(BuildContext context, GoRouterState state) =>
      const CompletedTask();

  const CompletedTask({super.key});

  @override
  ConsumerState<CompletedTask> createState() => _CompletedTaskState();
}

class _CompletedTaskState extends ConsumerState<CompletedTask> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final taskState = ref.watch(taskProvider);

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
                          'Completed task',
                          style: context.textTheme.headlineMedium,
                        ),
                        const Gap(10),
                        DisplayListOfTasks(
                          tasks: _completedTasks(taskState.tasks, ref),
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

  List<Task> _completedTasks(List<Task> tasks, WidgetRef ref) {
    final List<Task> filteredTasks = [];
    for (var task in tasks) {
      if (task.isCompleted) {
        filteredTasks.add(task);
      }
    }
    return filteredTasks;
  }
}
