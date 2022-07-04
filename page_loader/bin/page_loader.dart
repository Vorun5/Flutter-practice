import 'package:page_loader/page_loader.dart';

void main(List<String> arguments) async {
  var p = PageLoader('https://www.travelline.ru', 'sites');
  await p.pageLoader();
  await p.uploadFiles(['.js', '.css', '.png', '.jpg', '.jpeg', '.gif']);
}
