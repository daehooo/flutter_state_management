import 'package:flutter/material.dart';
import 'package:flutter_practice/inheritedwidget_example/inherited_parent.dart';

class Child extends StatelessWidget {
  const Child({super.key});
  
  @override
  Widget build(BuildContext context) {
    /// BuildContext를 이용하여 InheritedParent 위젯에 접근
    InheritedParent inherited = context.dependOnInheritedWidgetOfExactType<InheritedParent>()!;
    return ElevatedButton(
      onPressed: inherited.onPressed,
      child: Text("Child : ${inherited.state}"),
    );
  }
}