import 'package:flutter/material.dart';
import 'package:flutter_practice/2-inherited_widget/cart.dart';
import 'package:flutter_practice/2-inherited_widget/state/inherited_cart.dart';
import 'package:flutter_practice/2-inherited_widget/store.dart';
import 'package:flutter_practice/common/bottom_bar.dart';
import 'package:flutter_practice/common/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// 현재 선택된 index
  int currentIndex = 0;

  List<Product> cartProductList = [];

  void onProductPressed(Product product) {
    setState(() {
      if(cartProductList.contains(product)) {
        // cartProductList.remove(product);
        // 기존 배열과 서로 다른것을 참조
        cartProductList = cartProductList.where((element) {
          return element != product;
        }).toList();
      } else {
        // cartProductList.add(product);
        cartProductList = [...cartProductList, product];
        // 다른 참조객체를 갖게 됨
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 오류발생. InheritedCart 생성전에, 접근하기 때문
    // 이를 해결하기 위해 builder를 통해 접근해야함.
    // final inheritedCart = context.read<InheritedCart>();

    return InheritedCart(
      cartProductList: cartProductList,
      onProductPressed: onProductPressed,
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: const [
            /// Store
            Store(),
      
            /// Cart
            Cart(),
          ],
        ),
        bottomNavigationBar: Builder(
          builder: (context) {
    final inheritedCart = context.read<InheritedCart>();

            return BottomBar(
              currentIndex: currentIndex,
              cartTotal: inheritedCart.cartProductList.length.toString(),
              onTap: (index) => setState(() {
                currentIndex = index;
              }),
            );
          }
        ),
      ),
    );
  }
}