// ignore_for_file: unused_element, unused_element_parameter

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  void _ref(Ref ref) {}

  void refPublic(
      // expect_lint: avoid_ref_parameter
      Ref ref) {}

  void _widgetRef(WidgetRef widgetRef) {}

  void widgetRefPublic(
      // expect_lint: avoid_ref_parameter
      WidgetRef widgetRef) {}
}

void _ref(
  // expect_lint: avoid_ref_parameter
  Ref ref, {
// expect_lint: avoid_ref_parameter
  Ref? ref3,
}) {}

void _widgetRef(
  // expect_lint: avoid_ref_parameter
  WidgetRef widgetRef, {
// expect_lint: avoid_ref_parameter
  WidgetRef? widgetRef3,
}) {}

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
