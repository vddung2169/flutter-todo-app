import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/ultils/extensions.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {super.key,
      required this.title,
      required this.hintText,
      this.controller,
      this.maxLine,
      this.suffixIcon,
      this.readonly = false});

  final String title;
  final String hintText;
  final TextEditingController? controller;
  final int? maxLine;
  final Widget? suffixIcon;
  final bool readonly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: context.textTheme.titleLarge,
        ),
        const Gap(10),
        TextField(
          readOnly: readonly,
          controller: controller,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
          ),
          maxLines: maxLine,
          onChanged: (value) {},
        )
      ],
    );
  }
}
