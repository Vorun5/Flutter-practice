import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter/widgets.dart';
import '../data/language.dart';
import '../style.dart';


part 'language_dropdown.g.dart';

@swidget
Widget languageDropdown(String label, Language value, ValueChanged<Language> onChanged) {
  return Row(
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: fontSize),
      ),
      const SizedBox(width: 24),
      DropdownButton<Language>(
        value: value,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple, fontSize: fontSize),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (Language? newValue) {
          if (newValue != null) {
            onChanged(newValue);
          }
        },
        items: Language.values
            .map((Language value) => DropdownMenuItem<Language>(
          value: value,
          child: Text(value.name),
        ))
            .toList(),
      ),
    ],
  );
}
