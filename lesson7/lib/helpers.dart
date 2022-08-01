import 'data/word.dart';

Set<int> getAllWordIds(List<Word> words) {
  final Set<int> ids = {};
  for (var word in words) {
    ids.add(word.id);
  }
  return ids;
}

int getNewIdForWord(List<Word> words) {
  var id = 0;
  for (var word in words) {
    if (id < word.id) {
      id = word.id;
    }
  }
  id++;
  return id;
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}