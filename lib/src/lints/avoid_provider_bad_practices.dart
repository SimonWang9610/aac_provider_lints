import 'package:aac_provider_lints/src/helper.dart';
import 'package:aac_provider_lints/src/riverpod_lint_rule.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

const _classParameter = LintCode(
  name: 'avoid_passing_provider_as_class_parameter',
  problemMessage: 'Provider bad practices detected',
  errorSeverity: ErrorSeverity.WARNING,
  correctionMessage:
      "Access it using WidgetRef/Ref inside Riverpod widgets/providers.",
);

const _dynamicProvider = LintCode(
  name: 'avoid_create_dynamic_provider',
  problemMessage: 'Provider bad practices detected',
  errorSeverity: ErrorSeverity.WARNING,
  correctionMessage:
      "Either make it as a global provider and access it using WidgetRef/Ref inside Riverpod widgets/providers."
      "If it is only used inside this class, consider converting it as Listenable or normal variables.",
);

class AvoidProviderBadPractices extends RiverpodLintRule {
  const AvoidProviderBadPractices() : super(code: _code);

  static const _code = LintCode(
    name: 'provider_bad_practices',
    problemMessage: 'Provider bad practices detected',
    errorSeverity: ErrorSeverity.WARNING,
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

      final isInitialized = variable.initializer != null;

      final parent = _hasClassOrFunctionParent(variable.parent);

      if (parent == 2) {
        reporter.atNode(variable, _dynamicProvider);
      } else if (parent == 1) {
        if (isInitialized) {
          reporter.atNode(variable, _dynamicProvider);
        } else {
          reporter.atNode(variable, _classParameter);
        }
      }

      return;
    });
  }

  /// 1: class, 2: function
  int _hasClassOrFunctionParent(AstNode? node) {
    if (node == null) {
      return 0;
    }

    if (node is ClassDeclaration) {
      return 1;
    }

    if (node is FunctionDeclaration) {
      return 2;
    }

    return _hasClassOrFunctionParent(node.parent);
  }
}
