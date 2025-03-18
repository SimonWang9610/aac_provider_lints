import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:riverpod_analyzer_utils/riverpod_analyzer_utils.dart';

class LintHelper {
  static bool isRiverpodProviderFromType(DartType type) {
    // return _providerChecker.isAssignableFromType(type);
    return providerOrFamilyType.isAssignableFromType(type);
  }

  static bool isAnyRef(DartType type) {
    return anyRefType.isAssignableFromType(type);
  }

  static bool isWidgetRef(DartType type) {
    return widgetRefType.isExactlyType(type);
  }

  static bool isRiverpodWidget(Element element) {
    return _riverpodWidgetChecker.isExactly(element);
  }

  static bool isWidgetBuildOrProviderBuild(MethodDeclaration method) {
    final methodName = method.declaredElement?.name;

    if (methodName != "build") return false;

    final enclosingClassType = method
        .thisOrAncestorOfType<ClassDeclaration>()
        ?.declaredElement
        ?.thisType;

    if (enclosingClassType == null) return false;

    final isWidget = _widgetChecker.isAssignableFromType(enclosingClassType);
    final isRiverpodAnnotated =
        checkIfHasRiverpodAnnotation(enclosingClassType.element);

    return isWidget ||
        isRiverpodAnnotated ||
        _stateChecker.isAssignableFromType(enclosingClassType);
  }

  /// target.watch(...), the target should be a subclass of Ref/WidgetRef
  /// target.read(...), the target should be a subclass of Ref/WidgetRef
  static bool isRiverpodTarget(Expression? target) {
    final targetType = target?.staticType;

    if (targetType == null) return false;

    final isRefType = isAnyRef(targetType);

    return isRefType;
  }

  /// check if the argument is a createFn of a provider
  static bool checkIfLegacyProvider(ArgumentList argumentList) {
    AstNode? ancestor = argumentList.parent;

    while (ancestor != null) {
      DartType? targetType;
      if (ancestor is InstanceCreationExpression) {
        final instanceType = ancestor.staticType;

        targetType = instanceType;
      } else if (ancestor is FunctionExpressionInvocation) {
        final type = ancestor.staticInvokeType;
        if (type != null && type is FunctionType) {
          targetType = type.returnType;
        }
      }

      if (targetType != null) {
        final isProvider = isRiverpodProviderFromType(targetType);

        if (isProvider) {
          return true;
        }
      }

      ancestor = ancestor.parent;
    }

    return false;
  }

  static bool checkIfWidgetFunction(NamedExpression namedExpression) {
    final type = namedExpression.staticType;
    if (type == null || type is! FunctionType) return false;
    final isWidget = _widgetChecker.isAssignableFromType(type.returnType);

    return isWidget;
  }

  static bool checkIfHasRiverpodAnnotation(Element? ele) {
    if (ele == null) return false;

    return riverpodType.hasAnnotationOfExact(ele);
  }

  static bool isRiverpodNotifier(DartType type) {
    return anyNotifierType.isAssignableFromType(type);
  }

  static bool isConsumerWidgetBuildMethod(MethodDeclaration method) {
    final enclosingClassType = method
        .thisOrAncestorOfType<ClassDeclaration>()
        ?.declaredElement
        ?.thisType;

    if (enclosingClassType == null) return false;

    return consumerWidgetType.isAssignableFromType(
          enclosingClassType,
        ) ||
        hookConsumerWidgetType.isAssignableFromType(enclosingClassType);
  }
}

const _riverpodWidgetChecker = TypeChecker.any([
  consumerWidgetType,
  hookConsumerWidgetType,
  consumerStatefulWidgetType,
  consumerStateType,
  statefulHookConsumerStateType,
]);

const _widgetChecker = TypeChecker.fromName("Widget", packageName: "flutter");

const _stateChecker = TypeChecker.fromName("State", packageName: "flutter");
