import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WidgetTwo extends StatefulWidget {
  final Provider<int> providerParam;
  final StateProvider<int> stateProviderParam;
  const WidgetTwo({
    super.key,
    required this.providerParam,
    required this.stateProviderParam,
  });

  @override
  State<WidgetTwo> createState() => _WidgetTwoState();
}

class _WidgetTwoState extends State<WidgetTwo> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static final _staticDynamicProvider = Provider((ref) => 0);
  static final _staticDynamicStateProvider = StateProvider((ref) => 0);

  final _dynamicProvider = Provider((ref) => 0);
  final _dynamicStateProvider = StateProvider((ref) => 0);

  void _providerAsMethodParam(
      Provider<int> providerParam, StateProvider<int> stateProviderParam) {}
}

void _providerAsFunctionParam(
    Provider<int> providerParam, StateProvider<int> stateProviderParam) {}
