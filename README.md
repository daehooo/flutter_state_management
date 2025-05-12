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

---

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
# 예: provider 상태관리 브랜치로 이동
git checkout provider-basic