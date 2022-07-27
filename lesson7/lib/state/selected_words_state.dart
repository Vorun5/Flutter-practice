import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lesson7/helpers.dart';
import '../data/word.dart';




class SelectedWordsNotifier  extends StateNotifier<Set<int>> {
  SelectedWordsNotifier(Set<int> initialValue) : super(initialValue);
}
final getSelectedWordsProvider = StateNotifierProvider.autoDispose.family<SelectedWordsNotifier, Set<int>, Set<int>> (
      (_, initialValue) => SelectedWordsNotifier(initialValue),
);
final wordsProvider = getSelectedWordsProvider({});


final selectedProvider = Provider.autoDispose((ref) => {
  
});