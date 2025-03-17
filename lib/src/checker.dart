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

      final isRef = LintHelper.isRef(type);

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

    final isRef = LintHelper.isRef(type);

    if (isRef) {
      reporter.atElement(
        variable,
        refParamCode,
      );
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

    final (method, fn) = _findClosetInvocationParent(invocation);

    LintCode? code;

    if (method != null && method.declaredElement?.name == "build") {
      // ref.read invoked inside build method
      code = refReadCode;
    } else if (fn is ArgumentList) {
      final isProviderCreation = LintHelper.checkIfLegacyProviderCreation(fn);

      // ref.read invoked inside a provider creation, like Provider((ref) => ref.read(provider))
      if (isProviderCreation) {
        code = refReadCode;
      }
    } else if (fn is NamedExpression) {
      final isWidgetFunction = LintHelper.checkIfWidgetFunction(fn);

      // ref.read invoked inside a named function that returns a widget,
      // like Builder(builder: (context) {ref.read(provider); ..., return Container();})
      if (isWidgetFunction) {
        code = refReadCode;
      }
    } else if (fn is FunctionDeclaration) {
      final riverpodAnnotated =
          LintHelper.checkIfHasRiverpodAnnotation(fn.declaredElement);

      // ref.read invoked inside a function provider (via riverpod generator)
      // like:
      /// ```dart
      /// @riverpod
      /// int myProvider(Ref ref) {
      ///  ref.read(provider);
      /// return 0;
      /// }
      /// ```
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

    final (method, fn) = _findClosetInvocationParent(invocation);

    LintCode? code;

    if (method != null && method.declaredElement?.name != "build") {
      code = refWatchCode;
    } else if (fn is ArgumentList) {
      final isProviderCreation = LintHelper.checkIfLegacyProviderCreation(fn);

      if (!isProviderCreation) {
        code = refWatchCode;
      }
    } else if (fn is NamedExpression) {
      final isWidgetFunction = LintHelper.checkIfWidgetFunction(fn);

      if (!isWidgetFunction) {
        code = refWatchCode;
      }
    } else if (fn is FunctionDeclaration) {
      final riverpodAnnotated =
          LintHelper.checkIfHasRiverpodAnnotation(fn.declaredElement);

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

(MethodDeclaration?, AstNode?) _findClosetInvocationParent(
    MethodInvocation invocation) {
  MethodDeclaration? callerDeclaration;
  FunctionExpression? callerFunction;

  invocation.thisOrAncestorMatching(
    (ancestor) {
      if (ancestor is MethodDeclaration) {
        callerDeclaration = ancestor;
        return true;
      } else if (ancestor is FunctionExpression) {
        callerFunction = ancestor;
        return true;
      }
      return false;
    },
  );

  return (callerDeclaration, callerFunction?.parent);
}
