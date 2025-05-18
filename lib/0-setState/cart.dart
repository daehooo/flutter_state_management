import 'package:flutter/material.dart';
import 'package:flutter_practice/common/product.dart';
import 'package:flutter_practice/common/product_tile.dart';

class Cart extends StatelessWidget {
  const Cart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Product> cartProductList = [];

    return Scaffold(
      body: cartProductList.isEmpty

          /// Empty
          ? const Center(
              child: Text(
                "Empty",
                style: TextStyle(fontSize: 24, color: Colors.grey),
              ),
            )

          /// Not Empty
          : ListView.builder(
              itemCount: cartProductList.length,
              itemBuilder: (context, index) {
                Product product = cartProductList[index];
                return ProductTile(
                  product: product,
                  isInCart: true,
                  onPressed: (product) {},
                );
              },
            ),
    );
  }
}