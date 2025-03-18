// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WidgetOne extends StatelessWidget {
  // expect_lint: avoid_provider_parameter
  final Provider<int> provider;
  // expect_lint: avoid_provider_parameter
  final StateProvider<int> stateProvider;
  // expect_lint: avoid_provider_parameter
  final FutureProvider<int> futureProvider;
  // expect_lint: avoid_provider_parameter
  final StreamProvider<int> streamProvider;
  const WidgetOne({
    super.key,
    required this.provider,
    required this.stateProvider,
    required this.futureProvider,
    required this.streamProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void _provider({
    // expect_lint: avoid_provider_parameter
    required Provider<int> provider,
    // expect_lint: avoid_provider_parameter
    required StateProvider<int> stateProvider,
    // expect_lint: avoid_provider_parameter
    required FutureProvider<int> futureProvider,
    // expect_lint: avoid_provider_parameter
    required StreamProvider<int> streamProvider,
  }) {}

  void providerPublic({
    // expect_lint: avoid_provider_parameter
    required Provider<int> provider,
    // expect_lint: avoid_provider_parameter
    required StateProvider<int> stateProvider,
    // expect_lint: avoid_provider_parameter
    required FutureProvider<int> futureProvider,
    // expect_lint: avoid_provider_parameter
    required StreamProvider<int> streamProvider,
  }) {}
}

void _provider({
  // expect_lint: avoid_provider_parameter
  required Provider<int> provider,
  // expect_lint: avoid_provider_parameter
  required StateProvider<int> stateProvider,
  // expect_lint: avoid_provider_parameter
  required FutureProvider<int> futureProvider,
  // expect_lint: avoid_provider_parameter
  required StreamProvider<int> streamProvider,
}) {}

class _NormalClass {
  // expect_lint: avoid_provider_parameter
  final Provider<int> provider;
  // expect_lint: avoid_provider_parameter
  final StateProvider<int> stateProvider;
  // expect_lint: avoid_provider_parameter
  final FutureProvider<int> futureProvider;
  // expect_lint: avoid_provider_parameter
  final StreamProvider<int> streamProvider;

  _NormalClass({
    required this.provider,
    required this.stateProvider,
    required this.futureProvider,
    required this.streamProvider,
  });
}
