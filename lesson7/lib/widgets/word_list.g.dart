// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_list.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class WordList extends StatelessWidget {
  const WordList(this.translate, this.words, this.addToSelectedWords,
      this.removeToSelectedWords,
      {Key? key})
      : super(key: key);

  final Translate translate;

  final Words words;

  final void Function(int) addToSelectedWords;

  final void Function(int) removeToSelectedWords;

  @override
  Widget build(BuildContext _context) =>
      wordList(translate, words, addToSelectedWords, removeToSelectedWords);
}

class WordListItem extends StatelessWidget {
  const WordListItem(this.language, this.word, {Key? key}) : super(key: key);

  final Language language;

  final Word word;

  @override
  Widget build(BuildContext _context) => wordListItem(language, word);
}

class CheckBox extends StatelessWidget {
  const CheckBox(
      this.ids, this.id, this.addToSelectedWord, this.removeToSelectedWord,
      {Key? key})
      : super(key: key);

  final Set<int> ids;

  final int id;

  final void Function(int) addToSelectedWord;

  final void Function(int) removeToSelectedWord;

  @override
  Widget build(BuildContext _context) =>
      checkBox(ids, id, addToSelectedWord, removeToSelectedWord);
}
