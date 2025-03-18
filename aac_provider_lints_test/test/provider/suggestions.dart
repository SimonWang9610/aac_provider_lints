// ignore_for_file: unused_element, unused_field, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'suggestions.g.dart';

class _Model {
  final int value;

  _Model(this.value);
}

// expect_lint: prefer_riverpod_generator
class MyNotifier extends StateNotifier<int> {
  MyNotifier() : super(0);

  void increment() {
    state++;
  }

  final _p1 = 0;

  final _p2 = _Model(0);

  // expect_lint: prefer_private_provider_property
  final p3 = 0;
  // expect_lint: prefer_private_provider_property
  final p4 = _Model(0);
  // expect_lint: prefer_private_provider_property
  int p5 = 0;
  // expect_lint: prefer_private_provider_property
  _Model p6 = _Model(0);

  static final sp7 = 0;
}

// expect_lint: prefer_riverpod_generator
class MyChangeNotifier extends ChangeNotifier {
  final _p1 = 0;

  final _p2 = _Model(0);

  // expect_lint: prefer_private_provider_property
  final p3 = 0;
  // expect_lint: prefer_private_provider_property
  final p4 = _Model(0);
  // expect_lint: prefer_private_provider_property
  int p5 = 0;
  // expect_lint: prefer_private_provider_property
  _Model p6 = _Model(0);

  static final sp7 = 0;
}

@riverpod
class ClassNotifier extends _$ClassNotifier {
  @override
  int build() {
    return 0;
  }

  final _p1 = 0;

  final _p2 = _Model(0);

  // expect_lint: prefer_private_provider_property
  final p3 = 0;
  // expect_lint: prefer_private_provider_property
  final p4 = _Model(0);
  // expect_lint: prefer_private_provider_property
  int p5 = 0;
  // expect_lint: prefer_private_provider_property
  _Model p6 = _Model(0);

  static final sp7 = 0;
}

@riverpod
class AsyncClassNotifier extends _$AsyncClassNotifier {
  @override
  FutureOr<int> build() async {
    return 0;
  }

  final _p1 = 0;

  final _p2 = _Model(0);

  // expect_lint: prefer_private_provider_property
  final p3 = 0;
  // expect_lint: prefer_private_provider_property
  final p4 = _Model(0);
  // expect_lint: prefer_private_provider_property
  int p5 = 0;
  // expect_lint: prefer_private_provider_property
  _Model p6 = _Model(0);

  static final sp7 = 0;
}
