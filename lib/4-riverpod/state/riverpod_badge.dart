import 'package:flutter_practice/4-riverpod/state/riverpod_cart.dart';
import 'package:flutter_practice/common/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final badgeProvider = NotifierProvider<RiverpodBadge, int> (() {
//   return RiverpodBadge();
// }); 

final badgeProvider = NotifierProvider<RiverpodBadge, int> (RiverpodBadge.new); 

class RiverpodBadge extends Notifier<int> {
  @override
  int build() {
    List<Product> cartProductList = ref.watch(cartProvider);
    return cartProductList.length;
  }
}