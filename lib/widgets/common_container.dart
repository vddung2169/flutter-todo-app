import 'package:flutter/material.dart';
import 'package:todo_app/ultils/extensions.dart';

class CommonContainer extends StatelessWidget {
  const CommonContainer({super.key, this.child, this.height});

  final Widget? child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.deviceSize.width,
      height: height,
      decoration: BoxDecoration(
          color: context.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }
}
