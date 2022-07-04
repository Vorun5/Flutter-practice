import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:beautiful_soup_dart/beautiful_soup.dart';

class PageLoader {
  // URI на сайт
  late final Uri _uri;

  // Путь к папке
  late final String _path;

  // Загружена ли страница (index.html)
  bool _load = false;

  bool get load => _load;

  PageLoader(String uri, String path) {
    if (p.extension(path).isNotEmpty) {
      throw FormatException('$_path is not folder');
    }
    _uri = Uri.parse(uri);
    final host = _uri.host;
    final sitePath = _uri.path;
    _path = '$path/$host$sitePath'.replaceAll(RegExp(r'[.?\|:*?]'), '-');
  }

  // Скачивает html страницы в index.html
  Future<String> pageLoader() async {
    try {
      final response = await http.Client().get(_uri);

      await Directory(_path).create(recursive: true);

      final path = '$_path/index.html';
      final pageFile = await File(path).create();
      await pageFile.writeAsBytes(response.bodyBytes);

      _load = true;

      final length = await pageFile.length();
      print('> Page is loaded into $path (length: ${length + 1})');
      return response.body;
    } catch (err) {
      print(err);
      _load = false;
      rethrow;
    }
  }

  Uri? _linkHandler(String? link, List<String> extensions) {
    if (link == null) {
      return null;
    }


    final uri = Uri.parse(link);
    final ex = p.extension(uri.path);
    if (!extensions.contains(ex)) {
      return null;
    }

    if (uri.host.isEmpty) {
      if (uri.path[0] != '/') {
        return Uri.parse('https://' + _uri.host + '/' + uri.path);
      }
      return Uri.parse('https://' + _uri.host + uri.path);
    }

    return uri;
  }

  Set<Uri> _parseLinksInHtmlAttr(String attr, List<String> extensions, String body) {
    final Set<Uri> links = {};
    BeautifulSoup bs = BeautifulSoup(body);
    bs.findAll('*', attrs: {attr: true}).forEach((e) {
      final link = e[attr];
      final uri = _linkHandler(link, extensions);
      if (uri != null) {
        links.add(uri);
      }
    });
    return links;
  }

  // Скачивает все файлы с нужным расшиернием
  Future<void> uploadFiles(List<String> extensions) async {
    // Првоеряем расширения на валидность
    for (var e in extensions) {
      final ex = e.replaceAll(RegExp(r'/]'), '');
      if (e.isEmpty || (e[0] != '.' || e.length == 1)) {
        throw ArgumentError('Invalid extension $e');
      }
      e = ex;
    }

    late final String pageBody;
    if (_load) {
      pageBody = File('$_path/index.html').readAsStringSync();
    } else {
      pageBody = await pageLoader();
    }

    final Set<Uri> links = _parseLinksInHtmlAttr('src', extensions, pageBody);
    links.addAll(_parseLinksInHtmlAttr('href', extensions, pageBody));

    // Создаём для каждого расширения файла свою папку
    final List<String> folderPaths = [];
    for (var e in extensions) {
      final folderName = e.replaceAll(RegExp(r'[.?\|:*?]'), '');
      final path = '$_path/files/$folderName';
      folderPaths.add(path);
      await Directory(path).create(recursive: true);
    }

    // Скачиваем файлы, если это возможно


    print('> Date\t|\tFile name\t|\tFile path\t|\tLength');
    for (var link in links) {
      String uri = link.path;
      final response = await http.Client().get(link);
      if (response.statusCode == 404) {
        print('> $uri not found 404');
        continue;
      }
      if (response.statusCode.isNegative) {
        continue;
      }

      final ex = p.extension(link.path);
      final filePath =
          folderPaths[extensions.indexOf(ex)] + '/' + p.basename(link.path);
      final file = await File(filePath).create();

      file.writeAsBytes(response.bodyBytes);
      final length = file.lengthSync();
      final date = file.lastModifiedSync();
      print('> $date | ${p.basename(uri)} | $filePath | ${length + 1}');
    }
  }
}
