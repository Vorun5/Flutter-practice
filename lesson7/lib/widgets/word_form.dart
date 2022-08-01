import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:lesson7/data/language.dart';
import 'package:lesson7/helpers.dart';
import '../style.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

part 'word_form.g.dart';





@hwidget
Widget wordForm(ValueChanged<Map<Language, String>> addWord) {
  final Map<Language, String> translate = {};

  Widget _textForm(Language language) {
    return TextFormField(
      decoration: InputDecoration(labelText: language.name.capitalize()),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter the word in ${language.name.capitalize()}';
        } else {
          translate[language] = value;
          return null;
        }
      },
    );
  }

  final formKey = GlobalKey<FormState>();
  return Form(
    key: formKey,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
            children: Language.values
                .map((language) => _textForm(language))
                .toList()),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              addWord(translate);
            }
          },
          child: const Text(
            'Add',
            style: TextStyle(fontSize: fontSize),
          ),
        )
      ],
    ),
  );
}
