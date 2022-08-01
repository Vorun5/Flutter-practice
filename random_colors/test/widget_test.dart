import 'package:flutter/material.dart';
import 'package:random_colors/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  testWidgets("Golden", (WidgetTester tester) async {
    await tester.pumpWidget(const RandomColorsApp());
    final addButton = find.text('Add');
    await tester.tap(addButton);
    await tester.tap(addButton);
    await tester.tap(addButton);
    await tester.tap(addButton);
    await tester.tap(addButton);
    await tester.tap(addButton);

    await tester.pump();
    final removeButton = find.text('Remove');
    final changeAllColorsButton = find.text('Change all colors');
    final gridView = find.byType(GridView);
    expect(gridView, matchesGoldenFile("img/grid.png"));
  });

  testWidgets('Test for add and remove buttons', (WidgetTester tester) async {

    await tester.pumpWidget(const RandomColorsApp());
    final addButton = find.text('Add');
    final removeButton = find.text('Remove');
    final changeAllColorsButton = find.text('Change all colors');

    expect( find.byType(GridView), findsOneWidget);

    expect(addButton, findsOneWidget);
    expect(removeButton, findsOneWidget);
    expect(changeAllColorsButton, findsOneWidget);

    expect(find.text('#1'), findsNothing);
    await tester.tap(addButton);
    await tester.pumpAndSettle();
    expect(find.text('#1'), findsOneWidget);

    expect(find.text('#2'), findsNothing);
    await tester.tap(addButton);
    await tester.pumpAndSettle();
    expect(find.text('#1'), findsOneWidget);
    expect(find.text('#2'), findsOneWidget);

    await tester.tap(removeButton);
    await tester.pumpAndSettle();
    expect(find.text('#1'), findsOneWidget);
    expect(find.text('#2'), findsNothing);

  });
}
