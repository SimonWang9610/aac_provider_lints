import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'read.g.dart';

@riverpod
class ReadOne extends _$ReadOne {
  @override
  int? build() {
    return null;
  }
}

@riverpod
class ReadTwo extends _$ReadTwo {
  @override
  int? build() {
    ref.read(readOneProvider);
    return null;
  }

  void side() {
    ref.read(readOneProvider);
  }
}
