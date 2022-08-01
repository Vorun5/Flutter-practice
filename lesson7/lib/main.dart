import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter/widgets.dart';
import 'package:lesson7/state/translate.dart';

part 'main.g.dart';

void main() {
  runApp(const MyApp());
}

@swidget
Widget myApp(BuildContext context) {
  return MaterialApp(
    home: SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Translate"),
        ),
        body: const ProviderScope(child: TranslatePage()),
      ),
    ),
  );
}