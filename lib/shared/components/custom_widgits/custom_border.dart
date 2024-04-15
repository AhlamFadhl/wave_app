import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:wave_app/shared/styles/colors.dart';

class CustomBorder extends StatelessWidget {
  final Widget child;
  final padding;
  final margin;
  final color;

  const CustomBorder(
      {required this.child,
      this.padding,
      this.margin,
      this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(0),
      padding: padding ?? const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: child,
    );
  }
}
