import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:product_page/product.dart';
import 'package:product_page/decimal_extensions.dart';

const _locale = 'ru-RU';
final _numberFormatter = NumberFormat.decimalPattern(_locale);
final _currencyFormatter = NumberFormat.simpleCurrency(locale: _locale);

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: _ImageContainer(image: product.image)),
        Text(
          '${product.price.formatWith(_numberFormatter)} ${_currencyFormatter.currencySymbol}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(product.name),
      ],
    );
  }
}

class _ImageContainer extends StatelessWidget {
  const _ImageContainer({Key? key, required this.image}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
          ),
        ),
        Positioned(
          right: 4,
          top: 4,
          child: SvgPicture.asset('assets/icons/heart.svg'),
        ),
      ],
    );
  }
}
