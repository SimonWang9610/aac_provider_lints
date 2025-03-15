import 'package:aac_provider_lints/src/helper.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:aac_provider_lints/src/riverpod_lint_rule.dart';

const _watchCode = LintCode(
  name: "always_ref_watch_in_build_method",
  problemMessage: "Bad ref practices detected.",
  errorSeverity: ErrorSeverity.WARNING,
  correctionMessage:
      "User ref.read outside of build methods to avoid unnecessary re-build.",
);

const _readCode = LintCode(
  name: "avoid_ref_read_in_build_method",
  problemMessage: "Bad ref practices detected.",
  errorSeverity: ErrorSeverity.WARNING,
  correctionMessage:
      "User ref.watch instead. If you did it purposely, consider moving the logic outside of build methods.",
);

// todo: avoid custom build methods different from the Widget.build and Provider.build
class AvoidRefBadPractices extends RiverpodLintRule {
  const AvoidRefBadPractices() : super(code: _code);

  static const _code = LintCode(
    name: 'ref_bad_practices',
    problemMessage: 'Bad ref practices detected.',
    errorSeverity: ErrorSeverity.WARNING,
  );

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

        final error = _checkRefWatch(invocation) ?? _checkRefRead(invocation);

        if (error != null) {
          reporter.atNode(invocation, error);
        }
      },
    );
  }

  LintCode? _checkRefWatch(MethodInvocation invocation) {
    final isWatch = invocation.methodName.name == 'watch';

    if (!isWatch) return null;

    final (method, fn) = _getFunctionExpression(invocation);

    /// BAD:
    /// ```dart
    /// <Non-Widget-Type> methodName() {
    ///   ref.watch(provider);
    /// }
    /// ```
    if (method != null && method.declaredElement?.name != "build") {
      return _watchCode;
    }

    final ancestor = fn?.parent;

    if (ancestor == null) return null;

    /// GOOD:
    /// ```dart
    /// final a = Provider((ref) => ref.watch(provider));
    /// ```
    if (ancestor is ArgumentList) {
      final isProviderCreation =
          LintHelper.checkIfLegacyProviderCreation(ancestor);

      if (!isProviderCreation) {
        return _watchCode;
      }

      return null;
    }

    /// BAD:
    /// ```dart
    /// TextButton(
    ///  onPressed: () {
    ///   ref.watch(provider);
    /// },
    /// child: Text("button"),
    /// ),
    /// ```
    if (ancestor is NamedExpression) {
      final isWidgetFunction = LintHelper.checkIfWidgetFunction(ancestor);

      if (!isWidgetFunction) {
        return _watchCode;
      }

      return null;
    }

    if (ancestor is FunctionDeclaration) {
      final riverpodAnnotated =
          LintHelper.checkIfHasRiverpodAnnotation(ancestor.declaredElement);

      if (!riverpodAnnotated) {
        return _watchCode;
      }

      return null;
    }

    return null;
  }

  LintCode? _checkRefRead(MethodInvocation invocation) {
    final isRead = invocation.methodName.name == 'read';

    if (!isRead) return null;

    final (method, fn) = _getFunctionExpression(invocation);

    /// BAD:
    /// ```dart
    /// Widget build(BuildContext context, WidgetRef ref) {
    ///  ref.read(provider);
    /// }
    /// ```
    ///
    /// ```dart
    /// Class Provider extends _$Provider {
    ///   @override
    ///   S build() {
    ///    ref.read(provider);
    ///  }
    /// }
    /// ```
    if (method != null && method.declaredElement?.name == "build") {
      return _readCode;
    }

    final ancestor = fn?.parent;

    if (ancestor == null) return null;

    /// BAD:
    /// ```dart
    /// final a = Provider((ref) => ref.read(provider));
    /// ```
    if (ancestor is ArgumentList) {
      final isProviderCreation =
          LintHelper.checkIfLegacyProviderCreation(ancestor);

      if (isProviderCreation) {
        return _readCode;
      }

      return null;
    }

    /// GOOD:
    /// ```dart
    /// TextButton(
    ///  onPressed: () {
    ///   ref.read(provider);
    /// },
    /// child: Text("button"),
    /// ),
    /// ```
    if (ancestor is NamedExpression) {
      final isWidgetFunction = LintHelper.checkIfWidgetFunction(ancestor);

      if (isWidgetFunction) {
        return _readCode;
      }

      return null;
    }

    if (ancestor is FunctionDeclaration) {
      final riverpodAnnotated =
          LintHelper.checkIfHasRiverpodAnnotation(ancestor.declaredElement);

      if (riverpodAnnotated) {
        return _readCode;
      }

      return null;
    }

    return null;
  }
}

(MethodDeclaration?, FunctionExpression?) _getFunctionExpression(
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

  return (callerDeclaration, callerFunction);
}
