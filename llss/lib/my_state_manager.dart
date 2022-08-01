import 'package:flutter/material.dart';

class MyInheritedNotifier<T extends ChangeNotifier>
    extends InheritedNotifier<T> {
  const MyInheritedNotifier(
      {Key? key, required T notifier, required Widget child})
      : super(key: key, notifier: notifier, child: child);
}

class MyProvider<T extends ChangeNotifier> extends StatefulWidget {
  const MyProvider(
      {Key? key, required this.create, required this.child})
      : super(key: key);
  final Widget child;
  final T Function() create;
  @override
  State<MyProvider<T>> createState() => _MyProviderState<T>();
}

class _MyProviderState<T extends ChangeNotifier> extends State<MyProvider<T>> {
  late final T _notifier = widget.create();
  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) =>
      MyInheritedNotifier<T>(notifier: _notifier, child: widget.child);
}