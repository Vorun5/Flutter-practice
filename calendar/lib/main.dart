import 'package:calendar/widgets/calendar/day/day.dart';
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Sample Code'),
      ),
      body: MyStatelessWidget("Hello", Colors.blue),
    ),
  )
);
