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

class HomeScreen extends ConsumerWidget {
  static HomeScreen builder(BuildContext context, GoRouterState state) =>
      const HomeScreen();

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorScheme;
    final sizeDevice = context.deviceSize;
    final taskState = ref.watch(taskProvider);

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    // DateTime date = DateTime(now.year, now.month, now.day);
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
                  DisplayWhiteText(
                      text: 'Today is: $formattedDate',
                      fontWeight: FontWeight.normal,
                      fontSize: 20),
                  const DisplayWhiteText(
                    text: 'My Todo List',
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  )
                ],
              ),
            ),
          ],
        ),
        Positioned(
            top: 170,
            right: 0,
            left: 0,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DisplayListOfTasks(tasks: taskState.tasks),
                  const Gap(20),
                  Text(
                    'Completed',
                    style: context.textTheme.headlineMedium,
                  ),
                  const Gap(10),
                  DisplayListOfTasks(
                    tasks: taskState.tasks,
                    isCompletedTasks: true,
                  ),
                  const Gap(20),
                  ElevatedButton(
                      onPressed: () => context.push(RouteLocation.createTask),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DisplayWhiteText(text: 'Add new task'),
                      )),
                ],
              ),
            ))
      ],
    ));
  }
}
