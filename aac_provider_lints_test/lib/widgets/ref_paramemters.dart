import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WidgetOne extends StatelessWidget {
  final Ref ref;
  final WidgetRef widgetRef;
  const WidgetOne({
    super.key,
    required this.ref,
    required this.widgetRef,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void _refMethod(WidgetRef widgetRef, Ref ref) {}
}

class WidgetThree extends ConsumerWidget {
  const WidgetThree({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }

  void acceptRefMethod(Ref ref, WidgetRef widgetRef) {}
}

class WidgetFour extends ConsumerStatefulWidget {
  const WidgetFour({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WidgetFourState();
}

class _WidgetFourState extends ConsumerState<WidgetFour> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void acceptRefMethod(Ref ref, WidgetRef widgetRef) {}
}

void _refFunction(Ref ref, WidgetRef widgetRef) {}

class NormalClass {
  void _refMethod(WidgetRef widgetRef, Ref ref) {}
}
