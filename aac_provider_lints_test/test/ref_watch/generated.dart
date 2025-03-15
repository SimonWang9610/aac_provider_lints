// ignore_for_file: unused_element
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated.g.dart';

@riverpod
bool f(Ref ref) {
  return false;
}

@Riverpod(keepAlive: true)
int fKeepAlive(Ref ref) {
  ref.watch(fProvider);

  return 0;
}

@riverpod
FutureOr<int> ff(Ref ref) {
  ref.watch(fProvider);
  return 0;
}

@riverpod
class S extends _$S {
  @override
  int build() {
    ref.watch(fProvider);
    return 0;
  }

  void side() {
    // expect_lint: always_ref_watch_in_build_method
    ref.watch(fProvider);
  }
}

@riverpod
class Async extends _$Async {
  @override
  FutureOr<int> build() {
    ref.watch(fProvider);
    return 0;
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
