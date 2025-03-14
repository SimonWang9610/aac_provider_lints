import 'package:aac_provider_lints/src/helper.dart';
import 'package:aac_provider_lints/src/riverpod_lint_rule.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class ProviderMustGlobal extends RiverpodLintRule {
  const ProviderMustGlobal() : super(code: _code);

  static const _code = LintCode(
    name: 'provider_must_be_global',
    problemMessage:
        'must not create providers inside class/function, or as a constructor parameter.',
    errorSeverity: ErrorSeverity.ERROR,
    correctionMessage:
        "make it as a global provider and access it using WidgetRef/Ref.",
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addVariableDeclaration((variable) {
      final type = variable.declaredElement?.type;

      if (type == null) return;

      final isProvider = LintHelper.isRiverpodProviderFromType(type);

      if (!isProvider) return;

      if (_hasClassOrFunctionParent(variable.parent)) {
        reporter.atNode(variable, _code);
      }
    });
  }

  bool _hasClassOrFunctionParent(AstNode? node) {
    if (node == null) {
      return false;
    }

    if (node is ClassDeclaration || node is FunctionDeclaration) {
      return true;
    }

    return _hasClassOrFunctionParent(node.parent);
  }
}
