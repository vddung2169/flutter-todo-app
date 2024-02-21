import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/config/routes/route_location.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/ultils/ultils.dart';
import 'package:todo_app/widgets/widgets.dart';

class InCompletedTask extends ConsumerStatefulWidget {
  static InCompletedTask builder(BuildContext context, GoRouterState state) =>
      const InCompletedTask();

  const InCompletedTask({super.key});

  @override
  ConsumerState<InCompletedTask> createState() => _InCompletedTaskState();
}

class _InCompletedTaskState extends ConsumerState<InCompletedTask> {
  late String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final taskState = ref.watch(taskProvider);
        final sizeDevice = context.deviceSize;

        return Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  const Gap(10),
                  SizedBox(
                    width: sizeDevice.width * 0.9,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search for todo...',
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(children: [
                      Text(
                        'Todo task',
                        style: context.textTheme.headlineMedium,
                      ),
                      const Gap(10),
                      DisplayListOfTasks(
                        tasks: _incompletedTasks(taskState.tasks, ref),
                        isCompletedTasks: true,
                      ),
                    ]),
                  ))
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  List<Task> _incompletedTasks(List<Task> tasks, WidgetRef ref) {
    final List<Task> filteredTasks = [];
    for (var task in tasks) {
      if (!task.isCompleted &&
          task.title.toLowerCase().contains(searchQuery.toLowerCase())) {
        filteredTasks.add(task);
      }
    }
    return filteredTasks;
  }
}
