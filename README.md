# 🧠 Flutter 상태관리 강의 정리

[Inflearn, Flutter 앱 개발 실전](https://www.inflearn.com/course/%ED%94%8C%EB%9F%AC%ED%84%B0-%EC%95%B1-%EA%B0%9C%EB%B0%9C-%EC%8B%A4%EC%A0%84) 위의 강의 내용을 정리합니다. 각각의 상태관리에 대한 정리와 이해를 할 수 있게됩니다.

Flutter에서 사용되는 다양한 상태관리 방식들을 학습하고 정리합니다. 각 브랜치에는 상태관리 방식별 예제 코드와 설명이 정리되어 있으며, 이 `main` 브랜치에는 가장 기본적인 `setState`를 이용한 예제 프로젝트가 포함되어 있습니다.

---

## 📌 브랜치 안내

| 상태관리 방식 | 브랜치명 | 설명 |
|--------------|----------|-----|
| ✅ setState | `main` | 가장 기본적인 상태관리 방식. 위젯 내부에서 상태 직접 제어 |
| 📦 InheritedWidget | `inheritedwidget-basic` | Flutter 기본 상태전달 메커니즘 |
| 🔄 Provider | `provider-basic` | ChangeNotifier 기반의 구조화된 상태관리 |
| 🌿 Riverpod | `riverpod-basic` | 최신 구조로 강력한 상태관리 도구 |
| 🔗 BLoC | `bloc-basic` | 이벤트-상태 기반의 구조화된 상태관리 방식 |

> 💡 브랜치를 전환하여 상태관리 방식의 코드들을 살펴보세요.

---

## ✅ 현재 브랜치: `inheritedwidget-basic`





## ✍️ 정리 방식

각 브랜치에는 다음 내용을 포함합니다:
- 개념 요약 (`README.md`)
- 상태관리 예제 코드

---

## 앱 이미지

<img src="https://github.com/daehooo/flutter_state_management/blob/main/assets/cart_app_image_1.png?raw=true" alt="카트 앱 실행 화면-1" width="300"/>
<img src="https://github.com/daehooo/flutter_state_management/blob/main/assets/cart_app_image_2.png?raw=true" alt="카트 앱 실행 화면-2" width="300"/>

## 🚀 브랜치 전환 방법

```bash
# 예: setState 상태관리 브랜치로 이동
git checkout main

# inheritedwidget 이해하기

### 📱 예제: `inheritedwidget`를 활용한 간단 예제

이 브랜치에서는 `inheritedwidget`를 이해하기 위한 간단한 예제 및 setState를 이용한 상태관리를 inheritedwidget로 바꾸어 적용하여 간단한 쇼핑카트 앱을 구현했습니다. 

### InheritedWidget 기본 개념

InheritedWidget은 자식 위젯이 중간 위젯을 거치지 않고 곧바로 접근 할 수 있는 위젯입니다. 이를 활용하여 Prop Drilling 문제를 해결할 수 있습니다.

<img src="https://github.com/daehooo/flutter_state_management/blob/inheritedwidget-basic/assets/inherited_widget_image.png?raw=true" alt="InheritedWidget 예제 화면" width="300"/>

### 1.InheritedWidget을 상속받아 구현할 수 있습니다.

```dart
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
```

InheritedWidget을 상속받고, updateShouldNotify 를 반드시 재정의 해줘야 합니다.
또한 상태를 생성자로 전달받아 가지고 있습니다.

### 2. 자식 위젯에선 context.dependOnInheritedWidgetOfExactType<클래스명>()를 이용해 InheritedWidget에에 접근할 수 있습니다. 따라서 생성자로 상태를 전달 받을 필요가 없습니다.

```dart
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
```

🍎 BuildContext를 이용하면, 부모에 접근할 수 있습니다. (단, 위젯 트리상에서 InheritedWidget 위젯보다 밑에 있는 위젯에서만 접근 가능합니다.) 


### 3. InheritedWidget은 자식 위젯의 접근을 돕는 역할 뿐이라, 상태 변경 및 갱신은 StatefulWidget을 이용해 구현하고, 값과 이벤트 함수를 전달 받았습니다.

```dart

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
```

### 4. updateShouldNotify()
해당 InheritedWidget에 접근하는 자식 위젯들의 갱신 여부를 결정합니다.

```dart
  @override
  bool updateShouldNotify(InheritedParent oldWidget) {
    print("updateShouldNotify : old = ${oldWidget.state} / new = $state");
    return state != oldWidget.state; // 자식 위젯 업데이트 여부
  }
```

### 💡 InheritedParent에서 updateShouldNotify()를 false로 반환하면, 자식 위젯이 갱신되지 않습니다.

참고로 Child 위젯이 const로 선언 되지 않는다면, 항상 갱신됩니다.
const로 생성된 위젯은 부모 위젯의 build() 메소드가 호출되어도 갱신이 되지 않지만, InheritedWidget을 내부에서 사용하는 경우엔 updateShouldNotify()에서 true를 반환하는 경우 갱신 됩니다.


## 이를 활용한 코드 적용



