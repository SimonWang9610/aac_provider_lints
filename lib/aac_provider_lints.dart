/// Support for doing something awesome.
///
/// More dartdocs go here.
library;

import 'package:aac_provider_lints/src/lints/avoid_dynamic_provider.dart';
import 'package:aac_provider_lints/src/lints/avoid_ref_bad_practices.dart';
import 'package:aac_provider_lints/src/lints/avoid_riverpod_parameters.dart';
import 'package:aac_provider_lints/src/lints/riverpod_provider_suggestion.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

// This is the entrypoint of our custom linter
PluginBase createPlugin() => _Linter();

/// A plugin class is used to list all the assists/lints defined by a plugin.
class _Linter extends PluginBase {
  /// We list all the custom warnings/infos/errors
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => const [
        // providers lints
        AvoidDynamicRiverpodProvider(),
        ...refInvocationLints,
        ...riverpodParameterLints,
        ...riverpodSuggestions,
      ];
}
