import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'my_divider.g.dart';

@swidget
Widget myDivider() {
  return const Divider(
    height: 30,
    thickness: 3,
    endIndent: 0,
    color: Colors.blue,
  );
}