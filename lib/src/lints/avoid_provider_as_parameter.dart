import 'package:aac_provider_lints/src/helper.dart';
import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:aac_provider_lints/src/riverpod_lint_rule.dart';

const _problem = "Bad ref practices detected.";
const _correction =
    "Access it using WidgetRef/Ref inside Riverpod widgets/providers.";

const _severity = ErrorSeverity.WARNING;

class AvoidProviderAsFunctionParameter extends RiverpodLintRule {
  const AvoidProviderAsFunctionParameter() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_provider_as_function_parameter',
    problemMessage: _problem,
    errorSeverity: _severity,
    correctionMessage: _correction,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    /// check if a parameter of a widget is a riverpod provider
    context.registry.addFunctionDeclaration((node) {
      final parameters = node.declaredElement?.parameters ?? [];

      for (final param in parameters) {
        final type = param.declaration.type;

        final isProvider = LintHelper.isRiverpodProviderFromType(type);

        if (isProvider) {
          reporter.atElement(param, code);
        }
      }
    });
  }
}

class AvoidProviderAsMethodParameter extends RiverpodLintRule {
  const AvoidProviderAsMethodParameter() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_provider_as_method_parameter',
    problemMessage: _problem,
    errorSeverity: _severity,
    correctionMessage: _correction,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    /// check if a parameter of a widget is a riverpod provider
    context.registry.addMethodDeclaration((node) {
      final parameters = node.declaredElement?.parameters ?? [];

      for (final param in parameters) {
        final type = param.declaration.type;

        final isProvider = LintHelper.isRiverpodProviderFromType(type);

        if (isProvider) {
          reporter.atElement(param, code);
        }
      }
    });
  }
}
