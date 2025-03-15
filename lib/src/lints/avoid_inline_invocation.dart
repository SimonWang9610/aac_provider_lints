import 'package:aac_provider_lints/src/helper.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:aac_provider_lints/src/riverpod_lint_rule.dart';

const _code = LintCode(
  name: 'avoid_inline_provider_invocation',
  problemMessage: "Bad ref practices detected.",
  correctionMessage:
      "Declare a variable and assign the inline invocation to it,"
      " like `final providerValue = ref.watch(provider);` Or wrap the inline invocation in a function.",
);

class AvoidInlineRefInvocation extends RiverpodLintRule {
  const AvoidInlineRefInvocation() : super(code: _code);

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation(
      (invocation) {
        final isRefTarget = LintHelper.isRiverpodTarget(invocation.target);
        if (!isRefTarget) return;

        final isInline = _isInlineInvocation(invocation);

        if (isInline) {
          reporter.atNode(invocation, _code);
        }
      },
    );
  }

  bool _isInlineInvocation(MethodInvocation invocation) {
    bool hasInlineElement = false;

    final block = invocation.thisOrAncestorMatching((ele) {
      if (hasInlineElement) return true;

      if (ele is ConditionalExpression ||
          ele is IfStatement ||
          ele is SwitchStatement ||
          ele is ArgumentList) {
        hasInlineElement = true;
      }

      if (ele is Block) return true;

      return false;
    });

    return hasInlineElement && block != null;
  }
}

//invocation
// ..ConditionalExpression
// ..IfStatement
// Block/ArgumentList/MethodDeclaration
