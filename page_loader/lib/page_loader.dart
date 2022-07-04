import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:beautiful_soup_dart/beautiful_soup.dart';

class PageLoader {
  late final Uri _uri;
  late final String _path;
  bool _load = false;
  final Set<String> _links = {};

  Set<String> get links => _links;

  bool get load => _load;

  PageLoader(String uri, String path) {
    _uri = Uri.parse(uri);
    final host = _uri.host;
    final sitePath = _uri.path;
    _path = '$path/$host$sitePath'
        .replaceAll(RegExp(r'[.?\|:*?]'), '-');
  }

  Future<String> pageLoader() async {
    try {
      final response = await http.Client().get(_uri);
      await Directory(_path).create(recursive: true);
      final pageFile = await File('$_path/index.html').create();
      await pageFile.writeAsBytes(response.bodyBytes);
      _load = true;
      return response.body;
    } catch (err) {
      print(err);
      _load = false;
      rethrow;
    }
  }

  void _linkHandler(String link, List<String> extensions) {
    var ex = path.extension(link);
    if (extensions.contains(ex)) {
      if (link[0] == '/') {
        link = _uri.host + link;
      }
      _links.add(link);
    }
  }

  Future<bool> parsePage(List<String> extensions) async {
    try {
      late final String pageBody;
      if (_load) {
        pageBody = File('$_path/index.html}').readAsStringSync();
      } else {
        pageBody = await pageLoader();
      }
      BeautifulSoup bs = BeautifulSoup(pageBody);
      bs.findAll('*', attrs: {'src': true}).forEach((e) {
        var link = e['src'];
        if (link != null) {
          _linkHandler(link!, extensions);
        }
      });

      bs.findAll('*', attrs: {'href': true}).forEach((e) {
        var link = e['src'];
        if (link != null) {
          _linkHandler(link!, extensions);
        }
      });
      return true;
    } catch (err) {
      _links.clear();
      print(err);
      rethrow;
    }
  }

}
