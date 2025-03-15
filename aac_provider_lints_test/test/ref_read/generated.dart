// ignore_for_file: unused_element
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated.g.dart';

@riverpod
int f(Ref ref) {
  return 0;
}

@Riverpod(keepAlive: true)
int fKeepAlive(Ref ref) {
  // expect_lint: avoid_ref_read_in_build_method
  ref.read(fProvider);
  return 0;
}

@riverpod
FutureOr<int> ff(Ref ref) {
  // expect_lint: avoid_ref_read_in_build_method
  ref.read(fProvider);
  return 0;
}

@riverpod
class S extends _$S {
  @override
  int build() {
    // expect_lint: avoid_ref_read_in_build_method
    ref.read(fProvider);
    return 0;
  }
}

@riverpod
class Async extends _$Async {
  @override
  FutureOr<int> build() {
    // expect_lint: avoid_ref_read_in_build_method
    ref.read(fProvider);
    return 0;
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
