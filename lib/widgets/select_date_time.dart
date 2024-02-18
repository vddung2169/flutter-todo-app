import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/ultils/ultils.dart';
import 'package:todo_app/widgets/common_text_field.dart';

class SelectDateTime extends ConsumerWidget {
  const SelectDateTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);

    return Row(
      children: [
        Expanded(
          child: CommonTextField(
            readonly: true,
            title: 'Date',
            hintText: DateFormat.yMMMd().format(date),
            suffixIcon: IconButton(
                onPressed: () => _selectDate(context, ref),
                icon: const FaIcon(FontAwesomeIcons.calendar)),
          ),
        ),
        const Gap(10),
        Expanded(
          child: CommonTextField(
            readonly: true,
            title: 'Time',
            hintText: Helpers.timeToString(time),
            suffixIcon: IconButton(
                onPressed: () => _selectTime(context, ref),
                icon: const FaIcon(FontAwesomeIcons.clock)),
          ),
        ),
      ],
    );
  }

  void _selectTime(BuildContext context, WidgetRef ref) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      ref.read(timeProvider.notifier).state = picked;
    }
  }

  void _selectDate(BuildContext context, WidgetRef ref) async {
    final initialDate = ref.read(dateProvider);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      ref.read(dateProvider.notifier).state = picked;
    }
  }
}
