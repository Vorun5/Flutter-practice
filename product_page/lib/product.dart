import 'package:decimal/decimal.dart';

class Product {
  Product(this.name, this.price, this.image);

  final String name;
  final Decimal price;
  final String image;
}
