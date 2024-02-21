import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/config/routes/routes.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/ultils/ultils.dart';
import 'package:todo_app/widgets/widgets.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static HomeScreen builder(BuildContext context, GoRouterState state) =>
      const HomeScreen();

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late String searchQuery = ''; // Add this variable to store the search query

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final colors = context.colorScheme;
        final sizeDevice = context.deviceSize;
        final taskState = ref.watch(taskProvider);
        final selectDate = ref.watch(dateProvider);

        final deviceSize = context.deviceSize;
        final height = deviceSize.height * 0.7;

        String formattedDate =
            DateFormat('yyyy-MM-dd – kk:mm').format(selectDate);

        return Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: sizeDevice.height * 0.3,
                    width: sizeDevice.width,
                    color: colors.primary,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => Helpers.selectDate(context, ref),
                          child: DisplayWhiteText(
                              text: formattedDate,
                              fontWeight: FontWeight.normal,
                              fontSize: 20),
                        ),
                        const DisplayWhiteText(
                          text: 'My Todo List',
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          children: [
                        const Gap(20),
                        Text(
                          'Todo',
                          style: context.textTheme.headlineMedium,
                        ),
                        const Gap(10),
                        DisplayListOfTasks(
                            tasks: _incompletedTasks(taskState.tasks, ref)),
                        const Gap(20),
                        Text(
                          'Upcoming',
                          style: context.textTheme.headlineMedium,
                        ),
                        const Gap(10),
                        DisplayListOfTasks(
                            tasks:
                                _upCommingTasks(taskState.tasks, selectDate)),
                        const Gap(20),
                        Text(
                          'Completed',
                          style: context.textTheme.headlineMedium,
                        ),
                        const Gap(10),
                        DisplayListOfTasks(
                          tasks: _completedTasks(taskState.tasks, ref),
                          isCompletedTasks: true,
                        ),
                        const Gap(20),
                        ElevatedButton(
                            onPressed: () =>
                                context.push(RouteLocation.createTask),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: DisplayWhiteText(text: 'Add new task'),
                            )),
                      ]))
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(sizeDevice.width * 0.05, 175, 0, 0),
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
