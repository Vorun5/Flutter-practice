import 'dart:io';
import 'package:http/http.dart' as http;

class PageLoader {
  late final Uri _uri;
  late final String _path;

  PageLoader(String uri, String path) {
    _uri = Uri.parse(uri);
    final host = _uri.host;
    final sitePath = _uri.path;
    _path = '$path/$host$sitePath'.replaceAll('.', '-');
    print('Path: $_path');
  }

  Future<String> pageLoader() async {
    try {
      final response = await http.Client().get(_uri);
      await Directory(_path).create(recursive: true);
      final pageFile = await File('$_path/index.html').create();
      await pageFile.writeAsBytes(response.bodyBytes);
      return 'ok';
    } catch (err) {
        print(err);
        rethrow;
    }
  }
}
