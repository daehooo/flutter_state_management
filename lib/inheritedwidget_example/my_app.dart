
import 'package:flutter/material.dart';
import 'package:flutter_practice/inheritedwidget_example/child.dart';
import 'package:flutter_practice/inheritedwidget_example/inherited_parent.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 공유 상태
  int state = 0;

  // 공유 상태 업데이트
  void increaseState() {
    setState(() {
      state += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("MyApp build 호출");
    return InheritedParent(
      state: state, // InheritedWidget에 state 전달
      onPressed: increaseState, // InheritedWidget에 increaseState 전달
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("state : $state"),
              const Child(), // 상태 변수와 이벤트 함수를 넘겨주지 않아도 됨(InheritedWidget 도입 효과)
            ],
          ),
        ),
      ),
    );
  }
}