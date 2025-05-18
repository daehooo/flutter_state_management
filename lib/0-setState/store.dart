
import 'package:flutter/material.dart';
import 'package:flutter_practice/common/product.dart';
import 'package:flutter_practice/common/product_tile.dart';

class Store extends StatelessWidget {
  const Store({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: storeProductList.length,
        itemBuilder: (context, index) {
          Product product = storeProductList[index];
          return ProductTile(
            product: product,
            isInCart: false,
            onPressed: (product) {},
          );
        },
      ),
    );
  }
}