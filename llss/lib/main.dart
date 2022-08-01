import 'package:flutter/material.dart';
import 'package:llss/test_app.dart';

// T? getInherit<T>(BuildContext context) {
//   final el =
//       context.getElementForInheritedWidgetOfExactType<DataProviderInherited>();
//   final widget = el?.widget;
//   if (widget is T) {
//     return widget as T;
//   } else {
//     return null;
//   }
// }

void main() {
  runApp(const MaterialApp(
    home: TestApp(),
  ));
}

class Example extends StatelessWidget {
  const Example({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Example",
      home: Scaffold(
        body: SimpleCalcWidget(),
      ),
    );
  }
}

class SimpleCalcWidget extends StatefulWidget {
  const SimpleCalcWidget({Key? key}) : super(key: key);

  @override
  State<SimpleCalcWidget> createState() => _SimpleCalcWidgetState();
}

class _SimpleCalcWidgetState extends State<SimpleCalcWidget> {
  final _model = SimpleCalcWidgetModel();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SimpleCalcWidgetProvider(
          model: _model,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              FirstNumberWidget(),
              SizedBox(height: 10),
              SecondNumberWidget(),
              SizedBox(height: 10),
              SumButtonWidget(),
              SizedBox(height: 10),
              ResultWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class FirstNumberWidget extends StatelessWidget {
  const FirstNumberWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      onChanged: (value) =>
          SimpleCalcWidgetProvider.of(context)?.firstNumber = value,
    );
  }
}

class SecondNumberWidget extends StatelessWidget {
  const SecondNumberWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(border: OutlineInputBorder()),
      onChanged: (value) =>
          SimpleCalcWidgetProvider.of(context)?.secondNumber = value,
    );
  }
}

class SumButtonWidget extends StatelessWidget {
  const SumButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => SimpleCalcWidgetProvider.of(context)?.sum(),
        child: const Text('Посчитать сумму'));
  }
}

class ResultWidget extends StatelessWidget {
  const ResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = SimpleCalcWidgetProvider.of(context)?.sumResult ?? '-1';
    return Text('Результат $value');
  }
}


// class ResultWidget extends StatefulWidget {
//   const ResultWidget({Key? key}) : super(key: key);
//
//   @override
//   State<ResultWidget> createState() => _ResultWidgetState();
// }
//
// class _ResultWidgetState extends State<ResultWidget> {
//   String _value = '-1';
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final model = SimpleCalcWidgetProvider.of(context).model;
//     model.addListener(() {
//       _value = '${model.sumResult}';
//       setState(() {});
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //final value = SimpleCalcWidgetProvider.of(context).model.sumResult ?? 0;
//     return Text('Результат: $_value');
//   }
// }

class SimpleCalcWidgetModel extends ChangeNotifier {
  int? _firstNumber;
  int? _secondNumber;
  int? sumResult;

  set firstNumber(String number) => _firstNumber = int.tryParse(number);

  set secondNumber(String number) => _secondNumber = int.tryParse(number);

  void sum() {
    int? sumResult;
    if (_firstNumber != null && _secondNumber != null) {
      sumResult = _firstNumber! + _secondNumber!;
    } else {
      sumResult = null;
    }
    if (this.sumResult != sumResult) {
      this.sumResult = sumResult;
      notifyListeners();
    }
  }
}

class SimpleCalcWidgetProvider extends InheritedNotifier<SimpleCalcWidgetModel> {
  final SimpleCalcWidgetModel model;

  const SimpleCalcWidgetProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, notifier: model, child: child);

  static SimpleCalcWidgetModel? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SimpleCalcWidgetProvider>()?.model;
  }

  // @override
  // bool updateShouldNotify(SimpleCalcWidgetProvider oldWidget) {
  //   return model != oldWidget.model;
  // }
}

// class DataOwnerStateful extends StatefulWidget {
//   const DataOwnerStateful({Key? key}) : super(key: key);
//
//   @override
//   State<DataOwnerStateful> createState() => _DataOwnerStatefulState();
// }
//
// class _DataOwnerStatefulState extends State<DataOwnerStateful> {
//   var _valueOne = 0;
//   var _valueTwo = 0;
//
//   void _incrimentOne() {
//     _valueOne += 1;
//     setState(() {});
//   }
//
//   void _incrimentTwo() {
//     _valueTwo += 1;
//     setState(() {});
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         ElevatedButton(onPressed: _incrimentOne, child: const Text("Жми раз")),
//         ElevatedButton(onPressed: _incrimentTwo, child: const Text("Жми два")),
//         DataProviderInherited(
//             valueOne: _valueOne, valueTwo: _valueTwo, child: const DataConsumerStateless()),
//       ],
//     );
//   }
// }
//
// class DataConsumerStateless extends StatelessWidget {
//   const DataConsumerStateless({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final value = context
//             .dependOnInheritedWidgetOfExactType<DataProviderInherited>(aspect: 'one')
//             ?.valueOne ??
//         0;
//
//     // context.findAncestorStateOfType<_DataOwnerStatefulState>()?._value ?? 0;
//     return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//       Text('$value'),
//       const DatConsumerStateful(),
//     ]);
//   }
// }
//
// class DatConsumerStateful extends StatefulWidget {
//   const DatConsumerStateful({Key? key}) : super(key: key);
//
//   @override
//   State<DatConsumerStateful> createState() => _DatConsumerStatefulState();
// }
//
// class _DatConsumerStatefulState extends State<DatConsumerStateful> {
//   @override
//   Widget build(BuildContext context) {
//     final value = context.dependOnInheritedWidgetOfExactType<DataProviderInherited>(aspect: 'two')?.valueTwo ?? 0;
//     return Text('$value');
//   }
// }
//
// class DataProviderInherited extends InheritedModel<String> {
//   final int valueOne;
//   final int valueTwo;
//
//   const DataProviderInherited({
//     Key? key,
//     required this.valueOne,
//     required this.valueTwo,
//     required Widget child,
//   }) : super(key: key, child: child);
//
//   @override
//   bool updateShouldNotify(DataProviderInherited oldWidget) {
//     return (valueOne != oldWidget.valueOne) || (valueTwo != oldWidget.valueTwo);
//   }
//
//   @override
//   bool updateShouldNotifyDependent(covariant DataProviderInherited oldWidget, Set<String> dependencies) {
//     final isValueOneUpdated = valueOne != oldWidget.valueOne && dependencies.contains('one');
//     final isValueTwoUpdated = valueTwo != oldWidget.valueTwo && dependencies.contains('two');
//     return isValueOneUpdated || isValueTwoUpdated;
//   }
// }
