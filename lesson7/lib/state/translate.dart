import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lesson7/state/translate_state.dart';
import 'package:lesson7/state/words_state.dart';
import 'package:lesson7/style.dart';
import 'package:lesson7/widgets/my_divider.dart';
import '../widgets/language_dropdown.dart';
import '../widgets/word_list.dart';

class TranslatePage extends ConsumerWidget {
  const TranslatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var translate = ref.watch(translateProvider);
    var words = ref.watch(wordsProvider);
    final int wordsLength = words.selectedWords.length;
    final String wordsLengthString =
        wordsLength == 0 ? "" : "$wordsLength words";
    return ListView(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            LanguageDropdown(
              'From:',
              translate.from,
              ref.read(translateProvider.notifier).changeFrom,
            ),
            LanguageDropdown(
              'To:',
              translate.to,
              ref.read(translateProvider.notifier).changeTo,
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
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: fontSize)),
            onPressed: () {},
            child: Text('Add word'),
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
        ]),
      ),
    ]);
  }
}
