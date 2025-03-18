import 'package:aac_provider_lints/src/codes.dart';
import 'package:aac_provider_lints/src/helper.dart';
import 'package:aac_provider_lints/src/riverpod_lint_rule.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidDynamicRiverpodProvider extends RiverpodLintRule {
  const AvoidDynamicRiverpodProvider();

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addVariableDeclaration(
      (variable) {
        final initializer = variable.initializer;
        final type = variable.declaredElement?.type;

        if (initializer == null || type == null) return;

        final isProvider = LintHelper.isRiverpodProviderFromType(type);

        if (!isProvider) return;

        final enclosedEle = _findEnclosingClassOrFunction(variable.parent);

        if (enclosedEle != null) {
          reporter.atNode(
            variable,
            dynamicProviderCode,
          );
        }
      },
    );
  }

  AstNode? _findEnclosingClassOrFunction(AstNode? node) {
    if (node == null) {
      return null;
    }

    if (node is ClassDeclaration || node is FunctionDeclaration) {
      return node;
    }

    return _findEnclosingClassOrFunction(node.parent);
  }
}
