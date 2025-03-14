import 'package:aac_provider_lints_test/providers/legacy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WidgetOne extends ConsumerWidget {
  const WidgetOne({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(legacyStateProvider);
    return Container(
      child: Consumer(
        builder: (context, innerRef, child) {
          innerRef.read(legacyStateProvider);
          return Container();
        },
        child: TextButton(
          onPressed: () {
            ref.read(legacyStateProvider);
          },
          child: Text("button"),
        ),
      ),
    );
  }

  void _side(WidgetRef widgetRef) {
    widgetRef.read(legacyStateProvider);
  }

  Widget _widget(WidgetRef ref) {
    return TextButton(
      onPressed: () {
        ref.read(legacyStateProvider);
      },
      child: Text("fn widget"),
    );
  }
}

class _TestClass {
  void _refMethod(WidgetRef widgetRef, Ref ref) {
    ref.read(legacyStateProvider);
    widgetRef.read(legacyStateProvider);
  }
}
