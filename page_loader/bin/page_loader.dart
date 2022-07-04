import 'package:page_loader/page_loader.dart';

void main(List<String> arguments) async {
  var p = PageLoader('https://www.travelline.ru', 'sites');
  p.pageLoader();
  if (await p.parsePage(['.js', '.css', '.png', '.jpg', '.jpeg'])) {
      print(p.links);
  }
}
