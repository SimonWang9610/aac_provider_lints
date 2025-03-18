<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 
-->

# Custom Riverpod bad practice lints

## TODO

## `avoid_ref_parameter`
The WidgetRef/Ref has their own lifecycle that is bound to the widget or provider self,
accessing a WidgetRef/Ref not belong to itself may cause inconsistent UI state and possible memory leaking

- passing `Ref` or `WidgetRef` as class parameters

```dart
/// ❌ Bad practice
class WidgetA extends StatelessWidget {
  // expect_lint: avoid_ref_parameter
  final Ref ref;
  // expect_lint: avoid_ref_parameter
  final WidgetRef widgetRef;
  const WidgetA({
    super.key,
    required this.ref,
    required this.widgetRef,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/// ❌ Bad practice
class _NormalClass {
  // expect_lint: avoid_ref_parameter
  final Ref ref;
  // expect_lint: avoid_ref_parameter
  final WidgetRef widgetRef;

  _NormalClass({
    required this.ref,
    required this.widgetRef,
  });
}
```

- passing `WidgetRef/Ref` as function/method parameters

```dart
/// ❌ Bad practice
void someFunction(Ref ref, WidgetRef widgetRef) {}

/// ❌ Bad practice
class SomeClass {
    void someMethod(Ref ref, WidgetRef widgetRef)
}
```

The only case we accept `WidgetRef` as a method parameter is that:
1. the widget is `ConsumerWidget`
2. the method is private

```dart
class WidgetA extends ConsumerWidget {
  const WidgetA({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
  /// we can ensure the WidgetRef's lifecycle is synced with this widget,
  /// as no others outside this file can invoke this method.
  void _privateMethod(WidgetRef ref) {}
}
```

## `avoid_provider_parameter`
Typically, riverpod providers should be a top-level variable, so we should avoid passing it as a parameter.
Instead, we should create it as a global variable, and then access it inside riverpod widgets/providers using `WidgetRef/Ref`

- passing providers as class parameters
```dart
/// ❌ Bad practice
class SomeWidget extends ConsumerWidget {
  final Provider<int> provider;
  final StateProvider<int> stateProvider;
  final FutureProvider<int> futureProvider;
  final StreamProvider<int> streamProvider;
  const SomeWidget({
    super.key,
    required this.provider,
    required this.stateProvider,
    required this.futureProvider,
    required this.streamProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
```

## `prefer_private_provider_property`

TODO

## `prefer_riverpod_generator`

TODO