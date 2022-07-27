import 'package:flutter/material.dart';


class LanguageDropdownField extends StatelessWidget {
  const LanguageDropdownField({
    required this.value,
    required this.onChanged,
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;
  final Language value;
  final ValueChanged<Language> onChanged;

  @override
  Widget build(BuildContext context) {
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
}