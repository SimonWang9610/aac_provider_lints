// ignore_for_file: unused_field, unused_element, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WidgetA extends StatefulWidget {
  const WidgetA({super.key});

  @override
  State<WidgetA> createState() => _WidgetAState();
}

class _WidgetAState extends State<WidgetA> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  // expect_lint: avoid_create_dynamic_provider
  final _provider = Provider<int>((ref) => 0);
  // expect_lint: avoid_create_dynamic_provider
  final _stateProvider = StateProvider<int>((ref) => 0);
  // expect_lint: avoid_create_dynamic_provider
  final _futureProvider = FutureProvider<int>((ref) async => 0);
  // expect_lint: avoid_create_dynamic_provider
  final _streamProvider = StreamProvider<int>((ref) async* {
    yield 0;
  });
}

class _NormalClass {
  // expect_lint: avoid_create_dynamic_provider
  static final _provider = Provider<int>((ref) => 0);
  // expect_lint: avoid_create_dynamic_provider
  static final _stateProvider = StateProvider<int>((ref) => 0);
  // expect_lint: avoid_create_dynamic_provider
  static final _futureProvider = FutureProvider<int>((ref) async => 0);
  // expect_lint: avoid_create_dynamic_provider
  static final _streamProvider = StreamProvider<int>((ref) async* {
    yield 0;
  });

  void _providerInsideFn() {
    // expect_lint: avoid_create_dynamic_provider
    final _provider = Provider<int>((ref) => 0);
    // expect_lint: avoid_create_dynamic_provider
    final _stateProvider = StateProvider<int>((ref) => 0);
    // expect_lint: avoid_create_dynamic_provider
    final _futureProvider = FutureProvider<int>((ref) async => 0);
    // expect_lint: avoid_create_dynamic_provider
    final _streamProvider = StreamProvider<int>((ref) async* {
      yield 0;
    });
  }
}
