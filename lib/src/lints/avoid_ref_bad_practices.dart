import 'package:aac_provider_lints/src/checker.dart';
import 'package:aac_provider_lints/src/codes.dart';
import 'package:aac_provider_lints/src/helper.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:aac_provider_lints/src/riverpod_lint_rule.dart';

class AvoidRefInvocationBadPractice extends RiverpodLintRule {
  const AvoidRefInvocationBadPractice();

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((invocation) {
      LintChecker.checkRefReadInvocation(invocation, reporter);
      LintChecker.checkRefWatchInvocation(invocation, reporter);
    });
  }
}

class AvoidInlineRefInvocation extends RiverpodLintRule {
  const AvoidInlineRefInvocation();

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
          reporter.atNode(invocation, refInlineCode);
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

const refInvocationLints = [
  AvoidRefInvocationBadPractice(),
  AvoidInlineRefInvocation(),
];
