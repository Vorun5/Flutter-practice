import 'package:page_loader/page_loader.dart';

void main(List<String> arguments) async {
  var p = PageLoader('https://www.lolhentai.net/index?/category/516-gwen', 'sites');
  await p.pageLoader();
  await p.uploadFiles(['.js', '.css', '.png', '.jpg', '.jpeg', '.gif']);
}
