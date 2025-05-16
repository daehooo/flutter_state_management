
import 'package:flutter_practice/common/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 제공자 등록해야함
// NotifierProvider가 일반적으로 많이 쓰임

final cartProvider = NotifierProvider<RiverpodCart, List<Product>>(() {
  return RiverpodCart();
});

class RiverpodCart extends Notifier<List<Product>> {
  @override
  List<Product> build() {
    // 상태변수의 초기값을 리턴해야함
    // 여기서는 List<Product>
    return [];
  }

  // 이렇게하면 깊은복사가 아니기 때문에 안됨!!
  void onProductPressed(Product product) {
    if(state.contains(product)) {
      // state.remove(product);
      state.where((element) => element != product).toList();
    
    } else {
      // state.add(product);
      state = [...state, product];
    }
  } 
}