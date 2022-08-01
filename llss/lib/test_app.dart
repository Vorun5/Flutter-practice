import 'dart:math';

import 'package:flutter/material.dart';

import 'my_state_manager.dart';

class AppState extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void incrementCounter() {
    _count++;
    _backgroundColor =
        Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    notifyListeners();
  }

  Color _backgroundColor = Colors.blue;

  Color get backgroundColor => _backgroundColor;

  Color get textColor =>
      _backgroundColor == Colors.yellow ? Colors.black87 : Colors.white;

  static AppState? of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<MyInheritedNotifier<AppState>>()!;
    assert(result != null, 'No MyInheritedWidget<AppState> in context');
    result.notifier!;
    return result.notifier;
  }
}

class TestApp extends StatelessWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = AppState.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Test App',
          style: TextStyle(
            color: appState?.textColor,
            backgroundColor: appState?.backgroundColor,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              'Tas',
              style: Theme.of(context).textTheme.headline4,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: appState?.incrementCounter,
        tooltip: 'Increment',
        backgroundColor: appState?.backgroundColor,
        child: Icon(
          Icons.add,
          color: appState?.textColor,
        ),
      ),
    );
  }
}
