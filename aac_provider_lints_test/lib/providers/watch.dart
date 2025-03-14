import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'watch.g.dart';

@riverpod
class WatchOne extends _$WatchOne {
  @override
  int? build() {
    return null;
  }
}

@riverpod
class WatchTwo extends _$WatchTwo {
  @override
  int? build() {
    ref.watch(watchOneProvider);
    ref.watch(familyWatchProvider(0));
    return null;
  }

  void sideEffect() {
    ref.watch(watchOneProvider);
    ref.watch(familyWatchProvider(0));
  }
}

@riverpod
class FamilyWatch extends _$FamilyWatch {
  @override
  int? build(Object? param) {
    return null;
  }
}
