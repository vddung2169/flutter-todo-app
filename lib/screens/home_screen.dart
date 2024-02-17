import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/ultils/ultils.dart';
import 'package:todo_app/widgets/common_container.dart';
import 'package:todo_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final sizeDevice = context.deviceSize;
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
                  const DisplayListOfTasks(tasks: [
                    Task(
                        title: 'Reading book',
                        note: 'Page 15',
                        time: '10:15',
                        date: '2024-02-18',
                        isCompleted: false),
                    Task(
                        title: 'Clean the house',
                        note: 'No',
                        time: '11:15',
                        date: '2024-02-18',
                        isCompleted: false)
                  ]),
                  const Gap(20),
                  Text(
                    'Completed',
                    style: context.textTheme.headlineMedium,
                  ),
                  const Gap(10),
                  const DisplayListOfTasks(
                    tasks: [
                      Task(
                          title: 'Code Flutter',
                          note: 'Page 15',
                          time: '10:15',
                          date: '2024-02-18',
                          isCompleted: true),
                      Task(
                          title: 'Up story Facebook',
                          note: 'No',
                          time: '11:15',
                          date: '2024-02-18',
                          isCompleted: true)
                    ],
                    isCompletedTasks: true,
                  ),
                  const Gap(20),
                  ElevatedButton(
                      onPressed: () {},
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
