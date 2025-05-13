

import 'package:flutter/material.dart';
import 'package:flutter_practice/common/product.dart';

class InheritedCart extends InheritedWidget {
  const InheritedCart({
    super.key,
    required super.child,
    required this.cartProductList,
    required this.onProductPressed,
  });

  // 카트에 담긴 상품 목록
  final List<Product> cartProductList;

  // 상품 클릭
  final void Function(Product product) onProductPressed;

  @override
  bool updateShouldNotify(InheritedCart oldWidget) {
    // return true;
    print("${cartProductList.length} / ${oldWidget.cartProductList.length}");
    return cartProductList != oldWidget.cartProductList;
    // 항상 false -> 같은 참조타입. 이기 때문입니다.

    // 새로운 객체를 만들기 위해 깊은 복사를 해야합니다.

  }

  static InheritedCart of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedCart>()!;
  }
}

// 추후에 provider를 사용할 때 context.read() 등등에 적용
extension BuildContextExt on BuildContext {
  T read<T extends InheritedWidget>() {
    return dependOnInheritedWidgetOfExactType<T>()!;
  }
}

