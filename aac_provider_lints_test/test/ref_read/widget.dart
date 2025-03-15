// ignore_for_file: unused_element
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'generated.dart';

class RiverpodB extends ConsumerStatefulWidget {
  const RiverpodB({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RiverpodBState();
}

class _RiverpodBState extends ConsumerState<RiverpodB> {
  @override
  Widget build(BuildContext context) {
    // expect_lint: avoid_ref_read_in_build_method
    ref.read(fProvider);

    return Column(
      children: [
        TextButton(
          onPressed: () {
            ref.read(fProvider);
          },
          child: Text("button"),
        ),
        Consumer(
          builder: (context, ref, child) {
            // expect_lint: avoid_ref_read_in_build_method
            ref.read(fProvider);
            return Container();
          },
        ),
        Text(
          // expect_lint: avoid_ref_read_in_build_method, avoid_inline_provider_invocation
          ref.read(fProvider).toString(),
        ),
      ],
    );
  }

  void side() {
    ref.read(fProvider);
  }

  void _inline() {
    if (
        // expect_lint: avoid_inline_provider_invocation
        ref.read(fProvider) == 0) {}

    switch (
        // expect_lint: avoid_inline_provider_invocation
        ref.read(fProvider)) {
      case 0:
        break;
    }
  }
}
