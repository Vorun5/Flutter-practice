// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_dropdown.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown(
      {Key? key,
      required this.mode,
      required this.label,
      required this.value,
      required this.onChanged})
      : super(key: key);

  final DisplayMode mode;

  final String label;

  final Language value;

  final void Function(Language) onChanged;

  @override
  Widget build(BuildContext _context) => languageDropdown(
      mode: mode, label: label, value: value, onChanged: onChanged);
}
