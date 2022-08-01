import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:lesson7/state/words_state.dart';
import '../data/language.dart';
import '../data/word.dart';
import '../state/translate_state.dart';
import '../style.dart';

part 'word_list.g.dart';

@swidget
Widget wordList(
    Translate translate,
    Words words,
    ValueChanged<int> addToSelectedWords,
    ValueChanged<int> removeToSelectedWords) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        children: words.words
            .map(
              (word) => WordListItem(translate.from, word),
            )
            .toList(),
      ),
      Column(
        children: words.words
            .map(
              (word) => WordListItem(translate.to, word),
            )
            .toList(),
      ),
      Column(
        children: words.words
            .map(
              (word) => MyCheckBox(
                words.selectedWords.contains(word.id),
                word.id,
                addToSelectedWords,
                removeToSelectedWords,
              ),
            )
            .toList(),
      )
    ],
  );
}

@swidget
Widget wordListItem(Language language, Word word) {
  return Text(
    word.translations[language] ?? '',
    style: const TextStyle(fontSize: fontSize),
  );
}

@swidget
Widget myCheckBox(bool v, int id,
    ValueChanged<int> addToSelectedWord,
    ValueChanged<int> removeToSelectedWord) {
  return Checkbox(
    checkColor: Colors.white,
    value: v,
    onChanged: (bool? value) =>
        ((value ?? false) ? addToSelectedWord : removeToSelectedWord)(id),
  );
}