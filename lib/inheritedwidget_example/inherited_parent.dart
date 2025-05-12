import 'package:flutter/material.dart';

class InheritedParent extends InheritedWidget {
  const InheritedParent({
    super.key,
    required super.child,
    required this.state,
    required this.onPressed,
  });

  final int state;
  final void Function() onPressed;

  @override
  bool updateShouldNotify(InheritedParent oldWidget) {
    print("updateShouldNotify : old = ${oldWidget.state} / new = $state");
    return state != oldWidget.state; // 자식 위젯 업데이트 여부
  }
}