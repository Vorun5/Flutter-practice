import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/language.dart';
import '../data/word.dart';
import '../helpers.dart';

@immutable
class Words {
  const Words(this.words, this.selectedWords);
  final List<Word> words;
  final Set<int> selectedWords;
}

class WordsNotifier  extends StateNotifier<Words> {
  WordsNotifier(Words initialValue) : super(initialValue);

  void addWords(Map<Language, String> translate) {
    var currentState = state;
    final word = Word(id: getTheBiggestId(currentState.words) + 1, translations: translate);
    currentState.words.add(word);
    state = Words(currentState.words, currentState.selectedWords);
  }

  void removeWords(int id) {
    var currentState = state;
    currentState.selectedWords.remove(id);
    for (var word in currentState.words) {
      if (word.id == id) {
        state = Words( currentState.words.remove(word) as List<Word>, currentState.selectedWords);
        continue;
      }
    }
  }

  void removeToSelectedWords(int id) {
    final selectedWords = state.selectedWords;
    selectedWords.remove(id);
    state = Words(state.words, selectedWords);

    // var currentState = state;
    // currentState.selectedWords.remove(id);
    // state = currentState;
  }

  void addToSelectedWords(int id) {
    final selectedWords = state.selectedWords;
    selectedWords.add(id);
    state = Words(state.words, selectedWords);
  }

  void deleteAllSelectedWords() {
    List<Word> words = [];
    for (var word in state.words) {
      if (!state.selectedWords.contains(word.id)) {
        words.add(word);
      }
    }
    state = Words(words, {});
  }



}
final getWordsProvider = StateNotifierProvider.autoDispose.family<WordsNotifier, Words, Words> (
      (_, initialValue) => WordsNotifier(initialValue),
);

final wordsProvider = getWordsProvider(Words(getWords(), {}));