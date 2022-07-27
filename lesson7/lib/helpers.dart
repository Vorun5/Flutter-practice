import 'data/word.dart';

Set<int> getAllWordIds(List<Word> words) {
  final Set<int> ids = {};
  for (var word in words) {
    ids.add(word.id);
  }
  return ids;
}

int getTheBiggestId(List<Word> words) {
  var id = 0;
  for (var word in words) {
    if (id > word.id) {
      id = word.id;
    }
  }
  return id;
}