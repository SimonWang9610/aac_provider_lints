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
    context.registry.addMethodDeclaration((node) {
      final methodName = node.declaredElement?.name;

      final isConsumerWidget = LintHelper.enclosingWithConsumerWidget(node);
      final isBuildMethod = node.declaredElement?.name == 'build';

      if (isConsumerWidget && isBuildMethod) return;

      final parameters = node.declaredElement?.parameters ?? [];

      final isPrivate = methodName != null && methodName.startsWith('_');

      LintChecker.checkRiverpodParameters(
        parameters,
        reporter,
        skipRefCheck: isPrivate && isConsumerWidget,
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
    // context.registry.addClassDeclaration(
    //   (node) {
    //     final declarations = node.members.whereType<FieldDeclaration>();

    //     for (final field in declarations) {
    //       final variables = field.fields.variables;

    //       for (final variable in variables) {
    //         final initialized = variable.initializer != null;

    //         if (!initialized) continue;

    //         final code = LintChecker.checkType(variable.declaredElement?.type);

    //         if (code != null) {
    //           reporter.atNode(
    //             variable,
    //             code,
    //           );
    //         }
    //       }
    //     }
    //   },
    // );

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

const riverpodParameterLints = [
  AvoidRiverpodFunctionParameter(),
  AvoidRiverpodMethodParameter(),
  AvoidRiverpodClassParameter(),
];
