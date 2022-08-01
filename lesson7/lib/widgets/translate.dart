import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lesson7/state/translate_state.dart';
import 'package:lesson7/state/words_state.dart';
import 'package:lesson7/style.dart';
import 'package:lesson7/widgets/my_divider.dart';
import '../display_mode_provider.dart';
import 'language_dropdown.dart';
import 'word_form.dart';
import 'word_list.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part 'translate.g.dart';

@hcwidget
Widget translatePage(WidgetRef ref) {
  var translate = ref.watch(translateProvider);
  var words = ref.watch(wordsProvider);

  final int wordsLength = words.selectedWords.length;
  final String wordsLengthString = wordsLength == 0 ? "" : "$wordsLength words";

  final displayMode = DisplayModeProvider.of(useContext());

  Widget _adaptiveContainer(
      {required List<Widget> children, required DisplayMode mode}) {
    switch (mode) {
      case DisplayMode.mobile:
        return Column(
          children: children.map((widget) =>
            Padding(padding: const EdgeInsets.fromLTRB(0, 0, 0, 15) , child: widget)
          ).toList(),
        );
      default:
        return  Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: children,
        );
    }
  }

  return ListView(children: [
    Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          LanguageDropdown(
            mode: displayMode,
            value: translate.from,
            onChanged: ref.read(translateProvider.notifier).changeFrom,
            label: 'From:',
          ),
          const Icon(IconData(
            0xef3f,
            fontFamily: 'MaterialIcons',
          )),
          LanguageDropdown(
            onChanged: ref.read(translateProvider.notifier).changeTo,
            label: 'To:',
            mode: displayMode,
            value: translate.to,
          ),
        ]),
      ),
    ),
    const MyDivider(),
    WordList(
        translate,
        words,
        ref.read(wordsProvider.notifier).addToSelectedWords,
        ref.read(wordsProvider.notifier).removeToSelectedWords),
    const MyDivider(),
    Align(
      alignment: Alignment.bottomCenter,
      child: _adaptiveContainer(children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: fontSize)),
          onPressed: () => showDialog<String>(
            context: useContext(),
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Add a word'),
              content: WordForm(ref.read(wordsProvider.notifier).addWords),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
          child: const Text('Add word'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: fontSize)),
          onPressed: wordsLength == 0
              ? null
              : () {
                  final result = words.words
                      .where((word) => words.selectedWords.contains(word.id))
                      .map((word) {
                    final translations = word.translations;
                    return '${translations[translate.from]} - ${translations[translate.to]}';
                  }).join("\n");
                  // ignore: avoid_print
                  print(result);
                },
          child: Text('Print $wordsLengthString'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: fontSize)),
          onPressed: wordsLength == 0
              ? null
              : ref.read(wordsProvider.notifier).deleteAllSelectedWords,
          child: Text('Delete $wordsLengthString'),
        ),
      ], mode: displayMode),
    ),
    const SizedBox(height: 30),
  ]);
}
