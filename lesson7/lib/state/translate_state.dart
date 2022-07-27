import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lesson7/data/language.dart';

@immutable
class Translate {
  const Translate(this.from, this.to);
  final Language from;
  final Language to;
}
class TranslateNotifier  extends StateNotifier<Translate> {
  TranslateNotifier(Translate initialValue) : super(initialValue);
  void changeFrom(Language from) {
    state = Translate(from, state.to);
  }
  void changeTo(Language to) {
    state = Translate(state.from, to);
  }
}
final getTranslateProvider = StateNotifierProvider.autoDispose.family<TranslateNotifier, Translate, Translate> (
      (_, initialValue) => TranslateNotifier(initialValue),
);
final translateProvider = getTranslateProvider(const Translate(Language.french, Language.english));