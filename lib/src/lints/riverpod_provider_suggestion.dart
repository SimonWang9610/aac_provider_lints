import 'package:aac_provider_lints/src/codes.dart';
import 'package:aac_provider_lints/src/helper.dart';
import 'package:aac_provider_lints/src/riverpod_lint_rule.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class PreferPrivateProviderProperty extends RiverpodLintRule {
  const PreferPrivateProviderProperty();

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((node) {
      final element = node.declaredElement;

      if (element == null) {
        return;
      }

      final isNotifier = LintHelper.isRiverpodNotifier(element.thisType);
      final isAnnotatedClass = LintHelper.checkIfHasRiverpodAnnotation(element);

      if (!isNotifier && !isAnnotatedClass) {
        return;
      }

      for (final field in node.members) {
        if (field is! FieldDeclaration || field.isStatic) {
          continue;
        }

        for (final variable in field.fields.variables) {
          final element = variable.declaredElement;

          if (element == null || element.isStatic || element.isConst) {
            continue;
          }

          final isRestricted = element.isPrivate ||
              element.hasProtected ||
              element.hasVisibleForTesting;

          if (!isRestricted) {
            reporter.atElement(
              element,
              publicPropertyCode,
            );
          }
        }
      }
    });
  }
}

class PreferRiverpodGenerator extends RiverpodLintRule {
  const PreferRiverpodGenerator();

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration((node) {
      final element = node.declaredElement;

      if (element == null) {
        return;
      }

      final isNotifier = LintHelper.isRiverpodNotifier(element.thisType);
      final isAnnotatedClass = LintHelper.checkIfHasRiverpodAnnotation(element);

      if (isNotifier && !isAnnotatedClass) {
        reporter.atNode(
          node,
          useGeneratorCode,
        );
      }
    });
  }
}

const riverpodSuggestions = [
  PreferPrivateProviderProperty(),
  PreferRiverpodGenerator(),
];
