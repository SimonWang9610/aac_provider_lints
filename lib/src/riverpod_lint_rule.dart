import 'package:aac_provider_lints/src/codes.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:riverpod_analyzer_utils/riverpod_analyzer_utils.dart';

abstract class RiverpodLintRule extends DartLintRule with _ParseRiverpod {
  const RiverpodLintRule({super.code = codePlaceholder});

  @override
  Future<void> startUp(
    CustomLintResolver resolver,
    CustomLintContext context,
  ) async {
    // await _setupRiverpod(resolver, context);
    await super.startUp(resolver, context);
  }
}

mixin _ParseRiverpod {
  static final _contextKey = Object();

  // ignore: unused_element
  Future<void> _setupRiverpod(
    CustomLintResolver resolver,
    CustomLintContext context,
  ) async {
    if (context.sharedState.containsKey(_contextKey)) return;
    // Only run the riverpod parsing logic once
    final registry = context.sharedState[_contextKey] = RiverpodAstRegistry();

    final unit = await resolver.getResolvedUnitResult();
    final result = ResolvedRiverpodLibraryResult.from([unit.unit]);

    context.addPostRunCallback(() => registry.run(result));
  }

  RiverpodAstRegistry riverpodRegistry(CustomLintContext context) {
    final registry = context.sharedState[_contextKey] as RiverpodAstRegistry?;
    if (registry == null) {
      throw StateError('RiverpodAstRegistry not initialized');
    }
    return registry;
  }
}
