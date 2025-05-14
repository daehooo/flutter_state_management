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

이 브랜치에서는 `provider`를 활용하여 간단한 쇼핑카트 앱을 구현했습니다.
Flutter 상태관리의 기초를 이해하는 데 도움이 됩니다.

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
# 예: setState 상태관리 브랜치로 이동
git checkout main
```

# Provider
✏️ Provider는 InheritedWidget을 보다 쉽게 사용할 수 있도록 도와주는 상태 관리 패키지입니다.

- 원하는 위젯만 선택적으로 갱신이 가능
- Lazy Loading 지원

## Provider 예제
### 1. Provider는 ChangeNotifier를 상속받거나, 믹스인한 클래스에서 상태를 가지고 있습니다.
- 변경사항이 있는 경우 notifyListeners() 를 호출하여 자식 위젯을 갱신합니다.

```dart
class MyProvider with ChangeNotifier {
    int counter = 0;

    void incrementCounter() {
        counter += 1;
        notifyListeners();
    }
}
```

### 2. InheritedWidget을 부모 위젯으로 추가했던 것과 마찬가지로, Provider를 위젯트리에 다음과 같이 추가해야 자식 위젯들이 접근할 수 있습니다.

```dart
void main() {
    runApp(
        ChangeNotifierProvider(
            create: (context) => MyProvider(),
            child: MaterialApp(
                home: MyApp(),
            ),
        ),
    );
}
```

ChangeNotifier를 이용한 Provider는 ChangeNotifierProvider 로 추가해줍니다.

### 3. 자식 위젯에서 context.watch() 로 Provider에 접근할 수 있으며 변경사항이 있어 notifyListeners()가 호출된다면, 해당 위젯의 build()함수가 재실행되며 화면을 갱신합니다.

```dart
class MyApp  extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        MyProvider myProvider = context.watch<MyProvider>();

        return Scaffold(
            body: Center(
                child: Text(
                    "${MyProvider.counter}",
                ),
            ),
        );
    }
}
```

context.watch()는 Provider 패키지에서 extension으로 BuildContext를 확장하여 구현한 함수입니다.
- 자세한 내용은 InheritedWidget에서 사용한 extension 부분을 참고해주세요.

## Provider 접근 방법
- 자식 위젯에서 Provider에 접근하는 방법

context.watch() - notifyListeners() 호출시 위젯 갱신
```dart
MyProvider myProvider = context.watch<MyProvider>();
```
context.read() - notifyListeners() 가 호출되어도 갱신하지 않음
```dart
MyProvider myProvider = context.read<MyProvider>();
```
context.select() - watch와 동일하나, 특정 속성이 변경된 경우에만 갱신
```dart
int counter = context.select<MyProvider, int>((myProvider) => myProvider.counter);
```

Consumer() - watch와 동일하나, 특정 위젯만 갱신
```dart
child: Consumer<MyProvider>(
    builder: (context, myProvider, child) {
        return Text(
            "${myProvider.counter}",
            style: TextStyle(fontSize: 24),
        );
    }
),
```

context.watch()를 특정 위젯에만 적용한 경우로 생각하면 됩니다.

Selector(): select와 동일하나, 특정 위젯만 갱신
```dart
Selector<MyProvider, int>(
    selector: (context, myProvider) => myProvider.counter,
    builder: (context, counter, child) {
        return Text(
            "${myProvider.counter}",
            style: TextStyle(fontSize: 24),
        );
    }
),
```

context.select() 를 특정 위젯에만 적용한 버전으로, 별도 위젯으로 분리하면 context.select()도 Selector() 와 동일한 기능을 수행

## Provider 제공자 종류
변경사항을 알릴 필요 ✅
- ChangeNotifierProvider 사용
```dart
class MyProvider with ChangeNotifier {
    int counter = 0;

    void incrementCounter() {
        counter += 1;
        notifyListeners();
    }
}

void main() {
    runApp(
        MaterialApp(
            home: ChangeNotifierProvider(
                create: (context) => MyProvider,
                child: MyApp(),
            ),
        ),
    ),
}
```


- 변경 사항 알릴 필요가 있는 클래스들을 ChangeNotifierProvider로 등록합니다.
- ChangeNotifier를 상속 받거나 믹스인한 클래스만 등록 가능합니다.


변경 사항을 알릴 필요 ❌ 
- Provider를 사용

```dart
class MyProvider with ChangeNotifier {
   int getIncreasedNumber(int i) {
    return i+1;
   }
}

void main() {
    runApp(
        MaterialApp(
            home: Provider(
                create: (context) => MyProvider,
                child: MyApp(),
            ),
        ),
    ),
}
```

상태를 가지고 있지 않거나, 화면을 갱신할 필요가 없는 클래스들은 Provider로 등록합니다. (API 호출 함수만 모아둔 클래스 등)
BuildContext를 이용해 쉽게 접근할 수 있으며, 하나의 인스턴스만 생성하여 여러곳에서 활용 가능합니다.

## Provider의 상호작용
- 특정 Provider의 상태가 변경될 때, 다른 Provider의 상태도 함께 변경되어야 되는 경우가 있습니다.

쇼핑목록에서 찜을 했을 경우에, 찜목록에 badge counter를 나타내어야 하는 상황을 생각해봅시다.
이때, Provider를 통해 MyCart, MyBadge 클래스를 관리합니다. 
MyBadge는 MyCart에 담긴 상품의 갯수를 읽어와 표기됩니다. 
이때에 상태관리간에 의존성이 생깁니다. 
MyBadge의 생성자에서 myCart.addListener(_myCartListener)를 호출합니다.
이것은 MyCart 객체가 자신의 상태를 변경하고 notifyListeners()를 호출할 때마다 MyBadge의 _myCartListener 메서드가 자동으로 호출되도록 등록하는 과정입니다.
리스너를 등록했다면, 반드시 dispose()를 통해 해제시켜줍니다.

예제코드를 살펴보겠습니다.
```dart
class MyCart with ChangeNotifier {
  List<String> productList = [];

  void add(String product) {
    productList.add(product);
    notifyListeners();
  }
}

class MyBadge with ChangeNotifier {
  MyBadge({
    required this.myCart,
  }) {
    /// MyCart에서 notifyListeners() 호출시 addListener() 호출 됨
    myCart.addListener(_myCartListener);
  }

  int counter = 0;
  final MyCart myCart;

  void _myCartListener() {
    print("MyCart addListener 호출 됨");
    counter += 1;
    notifyListeners();
  }

  @override
  void dispose() {
    /// MyBadge dispose시 listener 등록 해제 해야함
    myCart.removeListener(_myCartListener);
    super.dispose();
  }
}

```

위의 상태관리들을 등록할때에 MultiProvider로 앱을 감싸줍니다.
이때에 MyBadge의 생성자에서 MyCart의 상태관리를 생성자로 사용하고 있으므로, MyCart를 우선적으로 등록합니다.
```dart
void main() {
    runApp(
        MultiProvider(
            providers: [
                ChangeNotifierProvider(
                    create: (context) => MyCart(),
                ),
                ChangeNotifierProvider(
                    create: (context) => MyBadge(myCart: context.read())
                ),
            ],
            child: MaterialApp(
                home: MyApp(),
            ),
        ),
    );
}
```

## Provider의 특징
- 상태를 별도 클래스로 분리하므로 StatefulWidget보다 관리가 용이
- InheritedWidget 보다 작성해야하는 코드 감소
- 원하는 위젯만 선택적 갱신이 가능
- Lazy Loading 지원 
    - 자식위젯이 접근하기 전 까지는 초기화를 하지 않음
    - 초반에 사용하지 않는 provider를 실행시키지 않아 가벼워짐
    - Provider가 부모 위젯으로 등록되어 있지 않은 경우, 자식 위젯에서 접근시 런타임 에러가 발생함
    - 위젯 트리상에 등록시 의존성 순서가 중요


## 코드 작성 적용해보기
작성된 코드를 보는것도 좋지만, 해당 내용을 직접 작성해봅시다.

### 1. 0-set_state 폴더에서 시작하세요.
해당 코드는 상태관리를 적용하지 않은 코드를 제공합니다.

### 2. provider 상태관리 추가하기
terminal에서 아래 명령어를 입력하여 패키지를 추가합니다.
```
flutter pub add provider
``` 

### 3. 상태관리 폴더 만들기
state 폴더를 만들고, 상태관리를 나타낼 provider_badge.dart, provider_cart.dart 파일을 만듭니다.
provider_badge 클래스는 provider_cart.dart에 정의된 상태인 cartProductList의 갯수를 읽어와야 하기때문에 의존성이 생깁니다. 자세한 내용은 위의 정리된 내용을 참고해주세요.
또한 생성자에 addListener를 통해 providerCart의 배열의 길이가 달라졌을 때를 감지합니다. 


```dart
// provider_cart.dart
class ProviderCart with ChangeNotifier {
  List<Product> cartProductList = [];

  void onProductPressed(Product product) {
    if(cartProductList.contains(product)) {
      cartProductList = cartProductList.where((cartProduct) {
        return cartProduct != product;
      }).toList();
    } else {
      cartProductList = [...cartProductList , product];
    }
      notifyListeners();
  } 
}

/// provider_badge.dart
class ProviderBadge with ChangeNotifier {
  ProviderBadge({
    required this.providerCart,
  }) {
    providerCart.addListener(providerCartListener);
  }

  int counter = 0;
  final ProviderCart providerCart;

  void providerCartListener() {
    counter = providerCart.cartProductList.length;
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    providerCart.removeListener(providerCartListener);
    super.dispose();
  }
}
```

### 4. 상태관리 적용하기
- 정의된 상태관리를 사용하여 화면에 나타내는 코드를 작성합니다.
이전 이론에서 배웠던, context.read, watch, select를 사용합니다.

1. store.dart 파일 수정
우선적으로 store.dart 파일을 수정합니다. 아래 코드는 storeProductList 배열을 ListView.builder를 사용하여 나타냅니다. watch를 통해 변화를 감지했을 때 build를 재실행하여 화면에 나타냅니다.

```dart

class Store extends StatelessWidget {
  const Store({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProviderCart providerCart = context.watch();
    return Scaffold(
      body: ListView.builder(
        itemCount: storeProductList.length,
        itemBuilder: (context, index) {
          Product product = storeProductList[index];
          return ProductTile(
            product: product,
            isInCart: providerCart.cartProductList.contains(product),
            onPressed: providerCart.onProductPressed,
          );
        },
      ),
    );
  }
}
```
2. cart.dart 파일 수정
provider_cart.dart에 정의된 cartProductList의 배열에 있는 상품들을 나타내는 화면입니다. `List<Product>` 형식만 나타내면 되므로, select를 이용하여 구현합니다.

```dart
final List<Product> cartProductList = context.select<ProviderCart, List<Product>>((productCart) => productCart.cartProductList );
```

위의 코드를 추가하면 상태관리를 통해 추가한 카트목록의 상품이 나타납니다.
또한 ProductTile의 onPressed 를 아래와 같이 수정합니다.

```dart
onPressed: context.read<ProviderCart>()onProductPressed,
```


home_page.dart 파일 수정

우선 Scaffold을 여러개의 상태관리를 위해 MultiProvider로 감쌉니다.
ProviderBadge는 생성자로 ProviderCart를 입력해야 합니다.

```dart
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderCart(),), 
        ChangeNotifierProvider(create: (context) => ProviderBadge(providerCart: context.read())), 
      ],
      child: Scaffold(
      ...
```

마지막으로, IndexedStack에 사용되는 badgeCounter를 사용하기 위해 Consumer위젯을 사용합니다. 해당 부분은 BottomBar에서만 사용되기 때문에 해당 위젯을 Consumer위젯을 Selector로 감쌉니다.

Select를 사용할때 타입에 주의해서 작성합니다.
필수 생성자는 selector, builder가 있고 selector에서 생성한 badgeProvider.counter를 사용하여 builder에 2번째 인자에 넣어 사용합니다.
```dart
bottomNavigationBar: Selector<ProviderBadge, int>(
          selector: (context, badgeProvider) => badgeProvider.counter,
          builder: (context, counter, child) {
            return BottomBar(
              currentIndex: currentIndex,
              cartTotal: counter.toString(),
              onTap: (index) => setState(() {
                currentIndex = index;
              }),
            );
          }
        ),
```

