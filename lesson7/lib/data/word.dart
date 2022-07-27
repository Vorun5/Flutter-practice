import 'language.dart';

class Word {
  Word({
    required this.translations,
    required this.id,
  });

  final int id;
  final Map<Language, String> translations;
}


final _words = [
  Word(
    id: 1,
    translations: {
      Language.english: 'hello',
      Language.french: 'bonjour',
      Language.german: 'hallo',
      Language.russian: 'привет',
    },
  ),
  Word(
    id: 2,
    translations: {
      Language.english: 'goodbye',
      Language.french: 'au revoir',
      Language.german: 'auf wiedersehen',
      Language.russian: 'до свидания',
    },
  ),
  Word(
    id: 3,
    translations: {
      Language.english: 'forest',
      Language.french: 'forêt',
      Language.german: 'wald',
      Language.russian: 'лес',
    },
  ),
  Word(
    id: 4,
    translations: {
      Language.english: 'nature',
      Language.french: 'la nature',
      Language.german: 'natur',
      Language.russian: 'природа',
    },
  ),
  Word(id: 5,
      translations: {
    Language.english: 'ocean',
    Language.french: 'océan',
    Language.german: 'ozean',
    Language.russian: 'океан',
  }),
];
/* pell:enable */

List<Word> getWords() => _words;