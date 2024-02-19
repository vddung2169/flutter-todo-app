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

class CreateTaskScreen extends ConsumerStatefulWidget {
  static CreateTaskScreen builder(BuildContext context, GoRouterState state) =>
      const CreateTaskScreen();
  const CreateTaskScreen({super.key});

  @override
  ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const DisplayWhiteText(text: 'Create New Task'),
        ),
        body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CommonTextField(
                  title: 'Title',
                  hintText: 'Enter task title',
                  controller: _titleController,
                ),
                const Gap(16),
                const SelectDateTime(),
                const Gap(16),
                CommonTextField(
                  title: 'Note',
                  hintText: 'Enter note for this task',
                  maxLine: 6,
                  controller: _noteController,
                ),
                const Gap(60),
                ElevatedButton(
                    onPressed: _createTask,
                    child: const DisplayWhiteText(text: 'Create '))
              ],
            )));
  }

  void _createTask() async {
    final title = _titleController.text.trim();
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);
    final note = _noteController.text.trim();

    if (title.isNotEmpty) {
      final task = Task(
          title: title,
          note: note,
          time: Helpers.timeToString(time),
          date: DateFormat.yMMMd().format(date),
          isCompleted: false);
      await ref.read(taskProvider.notifier).createTask(task).then((value) {
        context.go(RouteLocation.home);
      });
    }
  }

  void deleteTasksTable() async {
    await ref.read(taskProvider.notifier).deleteTable();
  }
}
