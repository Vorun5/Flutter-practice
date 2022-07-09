import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:product_page/product.dart';
import 'package:product_page/product_card.dart';
import 'package:product_page/product_card_service.dart';

class ProductGridView extends StatefulWidget {
  const ProductGridView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductGridViewState();
  }
}

const _productPageSize = 20;

class ProductGridViewState extends State<ProductGridView> {
  final _scrollController = ScrollController(initialScrollOffset: 5.0);
  final _products = <Product>[];
  final _random = Random();
  int pageCount = 1;

  @override
  void initState() {
    _addData(1);
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 0.75,
      ),
      controller: _scrollController,
      children: _products
          .map(
            (product) => ProductCard(product: product),
          )
          .toList(),
    );
  }

  void _addData(int pageNumber) {
    _products.addAll(
        List<Product>.generate(_productPageSize, (_) => getProduct(_random)));
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        _addData(pageCount);
        pageCount += 1;
      });
    }
  }
}
