// ignore_for_file: unused_element
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _p = Provider<int>((ref) => 0);
final _pAutoDispose = Provider.autoDispose<int>((ref) => 0);
final _pFamily = Provider.family<int, int>((ref, a) => 0);
final _pFamilyAutoDispose =
    Provider.family.autoDispose<int, int>((ref, a) => 0);
final _pAutoDisposeFamily =
    Provider.autoDispose.family<int, int>((ref, a) => 0);

final _s = StateProvider<bool>((ref) {
  ref.watch(_p);
  ;
  return false;
});

final _sAutoDispose = StateProvider.autoDispose<bool>((ref) {
  ref.watch(_p);
  ;
  return false;
});

final _sFamily = StateProvider.family<int, int>((ref, a) {
  ref.watch(_p);
  ;
  return 0;
});

final _sFamilyAutoDispose =
    StateProvider.family.autoDispose<int, int>((ref, a) {
  ref.watch(_p);
  ;
  return 0;
});

final _sAutoDisposeFamily =
    StateProvider.autoDispose.family<int, int>((ref, a) {
  ref.watch(_p);

  return 0;
});

final _f = FutureProvider<int>((ref) async {
  ref.watch(_p);
  return 0;
});

final _fAutoDispose = FutureProvider.autoDispose<int>((ref) async {
  ref.watch(_p);
  return 0;
});

final _fFamily = FutureProvider.family<int, int>((ref, a) async {
  ref.watch(_p);
  return 0;
});

final _fFamilyAutoDispose =
    FutureProvider.family.autoDispose<int, int>((ref, a) async {
  ref.watch(_p);
  return 0;
});

class _Notifier extends StateNotifier<int> {
  _Notifier() : super(0);
}

final _n = StateNotifierProvider<_Notifier, int>((ref) {
  ref.watch(_p);
  return _Notifier();
});

final _nAutoDispose = StateNotifierProvider.autoDispose<_Notifier, int>((ref) {
  ref.watch(_p);
  return _Notifier();
});

final _nFamily = StateNotifierProvider.family<_Notifier, int, int>((ref, a) {
  ref.watch(_p);
  return _Notifier();
});

final _nFamilyAutoDispose =
    StateNotifierProvider.family.autoDispose<_Notifier, int, int>((ref, a) {
  ref.watch(_p);
  return _Notifier();
});
