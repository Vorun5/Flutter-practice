import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter/widgets.dart';
import 'package:lesson7/helpers.dart';
import '../data/language.dart';
import '../display_mode_provider.dart';
import '../style.dart';

part 'language_dropdown.g.dart';

@swidget
Widget languageDropdown(
    {required DisplayMode mode,
    required String label,
    required Language value,
    required ValueChanged<Language> onChanged}) {
  Widget _dropDownButton() {
    return DropdownButton<Language>(
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
                child: Text(value.name.capitalize()),
              ))
          .toList(),
    );
  }


  switch (mode) {
    case DisplayMode.mobile:
      return _dropDownButton();
    default:
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: fontSize),
          ),
          const SizedBox(width: 24),
          _dropDownButton(),
        ],
      );
  }
}