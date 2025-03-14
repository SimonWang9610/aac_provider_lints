import 'package:aac_provider_lints/src/helper.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:aac_provider_lints/src/riverpod_lint_rule.dart';

const _problem = "WidgetRef/Ref has lifecycle bound to provider/widgets.";
const _correction =
    "Create a ConsumerWidget/ConsumerStatefulWidget to use its WidgetRef, or create a provider to use its Ref.";

const _severity = ErrorSeverity.WARNING;

class AvoidRefAsFunctionParameter extends RiverpodLintRule {
  const AvoidRefAsFunctionParameter() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_ref_as_function_parameter',
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
    /// check if a parameter of a widget is a widget ref
    context.registry.addFunctionDeclaration((node) {
      final parameters = node.declaredElement?.parameters ?? [];

      for (final param in parameters) {
        final type = param.declaration.type;

        final isWidgetRef = LintHelper.isRef(type);

        if (isWidgetRef) {
          reporter.atElement(param, _code);
        }
      }
    });
  }
}

class AvoidRefAsMethodParameter extends RiverpodLintRule {
  const AvoidRefAsMethodParameter() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_ref_as_method_parameter',
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
    /// check if a parameter of a widget is a widget ref
    context.registry.addMethodDeclaration((node) {
      final parameters = node.declaredElement?.parameters ?? [];

      final ancestor = node.thisOrAncestorMatching(
          (ancestor) => _isRiverpodRelatedClass(ancestor));

      if (ancestor != null) return;

      for (final param in parameters) {
        final type = param.declaration.type;

        final isWidgetRef = LintHelper.isRef(type);

        if (isWidgetRef) {
          reporter.atElement(param, _code);
        }
      }
    });
  }

  bool _isRiverpodRelatedClass(AstNode node) {
    if (node is! ClassDeclaration) return false;

    final superClassElement = node.extendsClause?.superclass.type?.element;

    if (superClassElement == null) return false;

    return LintHelper.isRiverpodWidget(superClassElement);
  }
}

class AvoidRefAsConstructorParameter extends RiverpodLintRule {
  const AvoidRefAsConstructorParameter() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_ref_as_constructor_parameter',
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
    /// check if a parameter of a widget is a widget ref
    context.registry.addClassMember((node) {
      final ele = node.declaredElement;

      if (ele == null) return;

      if (ele is! FieldElement) return;

      final isRef = LintHelper.isRef(ele.type);

      if (isRef) {
        reporter.atElement(ele, _code);
      }
    });
  }
}
