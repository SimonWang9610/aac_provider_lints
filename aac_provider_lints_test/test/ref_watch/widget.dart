// ignore_for_file: unused_element
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'generated.dart';

class RiverpodA extends ConsumerStatefulWidget {
  const RiverpodA({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RiverpodAState();
}

class _RiverpodAState extends ConsumerState<RiverpodA> {
  @override
  Widget build(BuildContext context) {
    ref.watch(fProvider);

    if (
        // expect_lint: avoid_inline_provider_invocation
        ref.watch(fProvider)) {}

    switch (
        // expect_lint: avoid_inline_provider_invocation
        ref.watch(fKeepAliveProvider)) {
      case 0:
        break;
    }

    return Column(
      children: [
        TextButton(
          onPressed: () {
            // expect_lint: always_ref_watch_in_build_method
            ref.watch(fProvider);
          },
          child: Text("button"),
        ),
        Consumer(
          builder: (context, ref, child) {
            ref.watch(fProvider);
            return Container();
          },
        ),
        // todo: implement lint for this case
        Text(
          // expect_lint: avoid_inline_provider_invocation
          ref.watch(fProvider).toString(),
        ),
        TextButton(
          onPressed:
              // expect_lint: avoid_inline_provider_invocation
              ref.watch(fProvider) ? () {} : null,
          child: Text("button"),
        ),
      ],
    );
  }

  void side() {
    // expect_lint: always_ref_watch_in_build_method
    ref.watch(fProvider);
  }

  void _inline() {
    if (
        // expect_lint: avoid_inline_provider_invocation, always_ref_watch_in_build_method
        ref.watch(fProvider)) {}

    switch (
        // expect_lint: avoid_inline_provider_invocation, always_ref_watch_in_build_method
        ref.watch(fKeepAliveProvider)) {
      case 0:
        break;
    }
  }
}
