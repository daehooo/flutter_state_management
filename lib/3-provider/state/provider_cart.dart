import 'package:flutter/material.dart';
import 'package:flutter_practice/common/product.dart';

class ProviderCart with ChangeNotifier {
  // 카트에 담긴 상품 목록
  List<Product> cartProductList = [];

  // 상품 클릭
  // 참조비교를 통해서는 아래와 같은 코드가 작용하지 않음
  // void onProductPressed(Product product) {
  //   if(cartProductList.contains(product)) {
  //     cartProductList.remove(product);
  //   } else {
  //     cartProductList.add(product);
  //   }
  //   notifyListeners();
  // }

  void onProductPressed(Product product) {
    if(cartProductList.contains(product)) {
      cartProductList = cartProductList.where((cartProduct) {
        return cartProduct != product;
      }).toList();
    } else {
      cartProductList = [...cartProductList, product];
    }
    notifyListeners();
  }
}