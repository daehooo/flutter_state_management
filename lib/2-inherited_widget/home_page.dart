import 'package:flutter/material.dart';
import 'package:flutter_practice/2-inherited_widget/cart.dart';
import 'package:flutter_practice/2-inherited_widget/store.dart';
import 'package:flutter_practice/common/bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// 현재 선택된 index
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          /// Store
          Store(),

          /// Cart
          Cart(),
        ],
      ),
      bottomNavigationBar: BottomBar(
        currentIndex: currentIndex,
        cartTotal: "0",
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
      ),
    );
  }
}