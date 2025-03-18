import 'package:aac_provider_lints/src/codes.dart';
import 'package:aac_provider_lints/src/helper.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class LintChecker {
  static void checkRiverpodParameters(
    List<ParameterElement> params,
    ErrorReporter reporter, {
    bool? skipRefCheck,
  }) {
    for (final param in params) {
      final type = param.declaration.type;

      final isRef = LintHelper.isAnyRef(type);

      if (isRef && (skipRefCheck == false)) {
        reporter.atElement(
          param,
          refParamCode,
        );
      }

      final isProvider = LintHelper.isRiverpodProviderFromType(type);

      if (isProvider) {
        reporter.atElement(
          param,
          providerParamCode,
        );
      }
    }
  }

  static void checkRiverpodVariable(
      VariableElement variable, ErrorReporter reporter) {
    final type = variable.declaration.type;

    final isRef = LintHelper.isAnyRef(type);

    if (isRef) {
      reporter.atElement(
        variable,
        refParamCode,
      );
      return;
    }

    final isProvider = LintHelper.isRiverpodProviderFromType(type);

    if (isProvider) {
      reporter.atElement(
        variable,
        providerParamCode,
      );
    }
  }

  static void checkRefReadInvocation(
      MethodInvocation invocation, ErrorReporter reporter) {
    final methodName = invocation.methodName.name;
    final isRead = methodName == 'read';

    if (!isRead) return;

    final ancestor = _findingEnclosingElement(invocation);

    LintCode? code;

    if (ancestor is MethodDeclaration &&
        LintHelper.isWidgetBuildOrProviderBuild(ancestor)) {
      code = refReadCode;
    } else if (ancestor is ArgumentList) {
      final isProviderCreation = LintHelper.checkIfLegacyProvider(ancestor);

      if (isProviderCreation) {
        code = refReadCode;
      }
    } else if (ancestor is NamedExpression) {
      final isWidgetFunction = LintHelper.checkIfWidgetFunction(ancestor);

      if (isWidgetFunction) {
        code = refReadCode;
      }
    } else if (ancestor is FunctionDeclaration) {
      final riverpodAnnotated =
          LintHelper.checkIfHasRiverpodAnnotation(ancestor.declaredElement);

      if (riverpodAnnotated) {
        code = refReadCode;
      }
    }
    if (code != null) {
      reporter.atNode(
        invocation,
        code,
      );
    }
  }

  static void checkRefWatchInvocation(
      MethodInvocation invocation, ErrorReporter reporter) {
    final methodName = invocation.methodName.name;
    final isWatch = methodName == 'watch';

    if (!isWatch) return;

    final ancestor = _findingEnclosingElement(invocation);

    LintCode? code;

    if (ancestor is MethodDeclaration &&
        !LintHelper.isWidgetBuildOrProviderBuild(ancestor)) {
      code = refWatchCode;
    } else if (ancestor is ArgumentList) {
      final isProviderCreation = LintHelper.checkIfLegacyProvider(ancestor);

      if (!isProviderCreation) {
        code = refWatchCode;
      }
    } else if (ancestor is NamedExpression) {
      final isWidgetFunction = LintHelper.checkIfWidgetFunction(ancestor);

      if (!isWidgetFunction) {
        code = refWatchCode;
      }
    } else if (ancestor is FunctionDeclaration) {
      final riverpodAnnotated =
          LintHelper.checkIfHasRiverpodAnnotation(ancestor.declaredElement);

      if (!riverpodAnnotated) {
        code = refWatchCode;
      }
    }

    if (code != null) {
      reporter.atNode(
        invocation,
        code,
      );
    }
  }
}

/// Find the closest element that encloses the invocation.
///
/// [MethodDeclaration] - ReturnType methodName() { [invocation] }
///
/// [ArgumentList] - methodName([invocation])
///
/// [NamedExpression] - nameParameter: ReturnType methodName() { [invocation] }
///
/// [FunctionDeclaration] - ReturnType fnName() { [invocation] }
AstNode? _findingEnclosingElement(MethodInvocation invocation) {
  AstNode? ancestor = invocation.parent;

  while (ancestor != null) {
    if (ancestor is MethodDeclaration) {
      return ancestor;
    } else if (ancestor is FunctionExpression) {
      return ancestor.parent;
    }

    ancestor = ancestor.parent;
  }

  return null;
}
