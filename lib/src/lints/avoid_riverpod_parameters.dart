import 'package:aac_provider_lints/src/checker.dart';
import 'package:aac_provider_lints/src/helper.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:aac_provider_lints/src/riverpod_lint_rule.dart';

// todo: check function closure
class AvoidRiverpodFunctionParameter extends RiverpodLintRule {
  const AvoidRiverpodFunctionParameter();
  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addFunctionDeclaration((node) {
      final parameters = node.declaredElement?.parameters ?? [];

      final ancestor = node.thisOrAncestorMatching(
          (ancestor) => LintHelper.isRiverpodRelatedClass(node));

      if (ancestor != null) return;

      final riverpodAnnotated =
          LintHelper.checkIfHasRiverpodAnnotation(node.declaredElement);

      LintChecker.checkRiverpodParameters(
        parameters,
        reporter,
        skipRefCheck: riverpodAnnotated,
      );
    });
  }
}

class AvoidRiverpodMethodParameter extends RiverpodLintRule {
  const AvoidRiverpodMethodParameter();

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    /// check if a parameter of a widget is a widget ref
    context.registry.addMethodDeclaration((node) {
      final methodName = node.declaredElement?.name;

      final parameters = node.declaredElement?.parameters ?? [];

      final ancestor = node.thisOrAncestorMatching(
          (ancestor) => LintHelper.isRiverpodRelatedClass(node));

      if (ancestor != null) return;

      final isPrivate = methodName != null && methodName.startsWith('_');

      LintChecker.checkRiverpodParameters(
        parameters,
        reporter,
        skipRefCheck: isPrivate,
      );
    });
  }
}

class AvoidRiverpodClassParameter extends RiverpodLintRule {
  const AvoidRiverpodClassParameter();

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addVariableDeclaration(
      (variable) {
        final initializer = variable.initializer;
        final ele = variable.declaredElement;

        if (initializer != null || ele == null) return;

        LintChecker.checkRiverpodVariable(ele, reporter);
      },
    );
  }
}

const parameterLints = [
  AvoidRiverpodFunctionParameter(),
  AvoidRiverpodMethodParameter(),
  AvoidRiverpodClassParameter(),
];
