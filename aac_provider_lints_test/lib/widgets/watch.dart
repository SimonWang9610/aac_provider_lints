import 'package:aac_provider_lints_test/providers/legacy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WidgetOne extends ConsumerWidget {
  const WidgetOne({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(legacyStateProvider);
    return Container(
      child: Consumer(
        builder: (context, innerRef, child) {
          innerRef.watch(legacyStateProvider);
          return Container();
        },
        child: TextButton(
          onPressed: () {
            ref.watch(legacyStateProvider);
          },
          child: Text("button"),
        ),
      ),
    );
  }

  void _watch(WidgetRef ref) {
    ref.watch(legacyStateProvider);
  }

  Widget _widget(WidgetRef ref) {
    return TextButton(
      onPressed: () {
        ref.watch(legacyStateProvider);
      },
      child: Text("fn widget"),
    );
  }
}
