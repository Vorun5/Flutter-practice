import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const dangerousCounterValue = 10;

final _dark = ThemeData(brightness: Brightness.dark);
final _light = ThemeData(brightness: Brightness.light);


@immutable
class MyTheme {
  const MyTheme(this.name, this.theme);

  final String name;
  final  ThemeMode theme;
}

class ThemeNotifier extends StateNotifier<MyTheme> {
  ThemeNotifier(MyTheme theme) : super(theme);

  void changeTheme(MyTheme theme) {
    state = theme;
  }
}

final getThemeProvider =
    StateNotifierProvider.autoDispose.family<ThemeNotifier, MyTheme, MyTheme>(
  (_, initialValue) => ThemeNotifier(initialValue),
);

final themeProvider = getThemeProvider(const MyTheme("Dark", ThemeMode.light));

// enum CounterValueLevel {
//   normal,
//   hight,
//   tooHight,
// }
//
// @immutable
// class Counter {
//   const Counter(this.value);
//
//   final int value;
//
//   CounterValueLevel get level {
//     if (value >= dangerousCounterValue) {
//       return CounterValueLevel.tooHight;
//     } else if (value >= dangerousCounterValue - 2) {
//       return CounterValueLevel.hight;
//     } else {
//       return CounterValueLevel.normal;
//     }
//   }
// }
//
// class CounterNotifier extends StateNotifier<Counter> {
//   CounterNotifier(int initialValue) : super(Counter(initialValue));
//
//   void increment() {
//     final currentValue = state.value;
//     state = Counter(
//       currentValue % 5 == 0 ? currentValue + 2 : currentValue + 1,
//     );
//   }
// }
//
// final getCounterProvider =
// StateNotifierProvider.autoDispose.family<CounterNotifier, Counter, int>(
//       (_, initialValue) => CounterNotifier(initialValue),
// );
//
// final counterProvider = getCounterProvider(2);
