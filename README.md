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

## ✅ 현재 브랜치: `main`

### 📱 예제: `setState`를 활용한 카트 앱

이 브랜치에서는 `setState`를 활용하여 간단한 쇼핑카트 앱을 구현했습니다. Flutter 상태관리의 기초를 이해하는 데 도움이 됩니다.

### 🧩 주요 기능
- BottomNavigationBar를 이용한 상품 Cart 나타내기
- 상품 장바구니 담기 / 제거하기
- Badge Package를 이용한 상품 장바구니 갯수 나타내기

### 🗂️ 프로젝트 구조

```
lib/
├── main.dart
├── 1-stateful_widget/
│   ├── cart.dart
│   ├── home_page.dart
│   └── store.dart
└── common/
    ├── bottom_bar.dart
    ├── product_tile.dart
    └── product.dart
```



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
# 예: riverpod 상태관리 브랜치로 이동
git checkout riverpod-basic
```

# Riverpod

## 특징
- 제공자 등록 편의성
    - Riverpod는 제공자를 전역 변수로 선언하며, ProviderScope로 감싸면 의존성 순서에 상관 없이 등록됩니다.

```dart
final a = StateProvider<int>((ref) => 0);
final b = StateProvider<int>((ref) => ref.watch(a) * 2);

ProviderScope(
    child: MyApp(),
),
```

- Flutter에 의존하지 않음
    - Provider는 Flutter프레임워크에서 제공하는 BuildContext를 사용

```dart
class MyWidget extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        Counter counter = context.watch<Counter>();
        return Text("${counter.count}");
    }
}
```

- Riverpod는 Flutter 프레임워크와 무관한 WidgetRef 를 별도로 만들어 사용합니다.

```dart
class MyWidget extends ConsumerWidget {

    @override
    Widget build(BuildContext context, WidgetRef ref) {
        Counter counter = ref.watch(counterProvider);
        return Text("${counter.count}");
    }
}
```

### Provider와 Riverpod 비교
- 상태등록 방법
Provider 상태 등록
-  ChangeNotifier를 상속받아 사용

Riverpod 상태 등록
- Notifier를 상속받아 사용

```dart
class Counter extends ChangeNotifier {
    int state = 0;

    void increment() {
        state++;
        notifyListeners();
    }
}

// Riverpod
class Counter extends Notifier<int> {
    @override
    int build() => 0;

    void increment() => state++;
}
```

등록
Provider
- ChangeNotifierProvider를 사용

Riverpod
- ProviderScope를 사용
```dart
// provider
void main() {
    runApp(
        ChangeNotifierProvider(
            create: (context) => Counter(),
            child: const MaterialApp(
                home: MyApp(),
            ),
        )
    );
}

// riverpod
void main() {
    runApp(
        ProviderScope(
            ProviderScope(
                child: MaterialApp(
                    home: MyApp(),
                ),
            ),
        ), 
    );
}
```

### Riverpod 접근 방법
Riverpod는 WidgetRef를 이용해 접근할 수 있습니다.
- ref.watch() : 상태 변경시 갱신 
- ref.read() : 갱신 없이 단순 접근

WidgetRef 를 가져오는 방법을 배워봅시다.
- StatelessWidget
```dart
class MyApp extends ConsumerWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context, WidgetRef ref) {
        int counter = ref.watch(counterProvider);
    }
}
```
- StatelessWidget을 ConsumerWidget으로 변경
- build() 메소드에 두 번째 파라미터로 WidgetRef ref 추가


- StatefulWidget
```dart
class MyApp extends ConsumerStatefulWidget {
    const MyApp({super.key});

    @override
    ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
    @override
    Widget build(BuildContext context) {
        int counter = ref.watch(counterProvider);
    }
}
```
- StatefulWidget을 ConsumerStatefulWidget로 변경
- State를 ConsumerState로 변경
- build() 메소드는 수정할 필요가 없으므로 ref라는 이름으로 WidgetRef를 사용할 수 있습니다.


### Riverpod 제공자 종류
- StateProvider, StateNotifierProvider, ChangeNotifierProvider, NotifierProvider, Provider 와 같은 다양한 제공자가 존재하지만, 가장 권장되는 제공자는 NotifierProvider 입니다.
- NotifierProvider
    - riverpod 2.0에서 추천하는 방법
    - Notifier를 상속받은 클래스만 NotifierProvider 에 등록이 가능합니다.
    - 중앙 집중식으로 모든 로직을 관리하므로 유지 관리에 좋습니다.
    - state의 참조(메모리 주소)가 바뀌는 경우 변경 사항을 알립니다.
```dart
final counterProvider = NotifierProvider<Counter, int>(() { return Counter();
});

class Counter extends Notifier<int> {
    @override
    int build() => 0;

    void increment() => state++;
}
```

### 💡 특정 Provider 상태가 변경될 때 다른 Provider도 함께 변경하는 방법을 배워봅시다.

Cart의 `state`가 변경될 때, Badge의 `state`를 함께 업데이트해 봅시다.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider = NotifierProvider<Cart, List<String>>(() => Cart());
final badgeProvider = NotifierProvider<Badge, int>(() => Badge());

class Cart extends Notifier<List<String>> {
  @override
  List<String> build() => [];

  void add(String product) => state = [...state, product];
}

class Badge extends Notifier<int> {
  @override
  int build() {
    final cartState = ref.watch(cartProvider);
    state = cartState.length;
    print("Badge build: $state");
    return state;
  }
}

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("MyApp build 호출 됨");
    
    int badgeState = ref.watch(badgeProvider);
    List<String> cartState = ref.watch(cartProvider);
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// MyCart - productList
            Text(
              "Cart : $cartState",
              style: const TextStyle(fontSize: 24),
            ),
            
            /// MyBadge - counter
            Text(
              "Badge : $badgeState",
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(cartProvider.notifier).add("Apple"),
        child: const Icon(Icons.add),
      ),
    );
  }
}
```


### autoDispose
NotifierProvider.autoDispose 를 사용하여 해당 Provider가 더 이상 사용되지 않는 경우 자동으로 삭제됩니다.
```dart

final counterProvider = NotifierProvider.autoDispose<Counter, int>(() {
  return Counter();
});

class Counter extends AutoDisposeNotifier<int> {
  @override
  int build() => 0;

  void increment() => state++;
}

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  child: const Text("Go to Home Page"),
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int counter = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
      ),
      body: Center(
        child: Text(
          "$counter",
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ref.read(counterProvider.notifier).increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}

```


## Riverpod의 특징
- Riverpod을 이용한 상태관리
    - 위젯 트리상에 직접 의존성 순서에 맞춰 등록할 필요가 없음
    - 동일한 Provider도 별도 변수로 선언하므로 접근할 수 있음
        - 전역변수가 늘어남
    - WidgetRef를 사용하여 Flutter에 의존하지 않음
        - ConsumerWidget과 같이 WidgetRef를 사용하기 위한 코드가 필요

