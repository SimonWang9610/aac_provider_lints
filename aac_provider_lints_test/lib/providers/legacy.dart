import 'package:flutter_riverpod/flutter_riverpod.dart';

final legacyStateProvider = StateProvider((ref) => 0);

final aProvider = Provider<int>(
  (ref) {
    ref.read(legacyStateProvider);
    ref.watch(legacyStateProvider);
    return 0;
  },
);

final bProvider = StateProvider<int>((ref) {
  ref.watch(aProvider);
  ref.read(aProvider);

  return 0;
});
