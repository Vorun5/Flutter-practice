import 'dart:io';

import 'package:page_loader/page_loader.dart';

Future<String> pageLoader() async {
  return 'ok';
}

void main(List<String> arguments) async {
  final p = PageLoader('https://github.com/Vorun5', 'sites');
  p.pageLoader();
}
