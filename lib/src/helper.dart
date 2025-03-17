import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:riverpod_analyzer_utils/riverpod_analyzer_utils.dart';

const _hooksWidgetRef =
    TypeChecker.fromName("WidgetRef", packageName: "hooks_riverpod");

class LintHelper {
  static bool isRiverpodProviderFromType(DartType type) {
    return _providerChecker.isAssignableFromType(type);
  }

  static bool isRef(DartType type) {
    return _refChecker.isAssignableFromType(type);
  }

  static bool isWidgetRef(DartType type) {
    return widgetRefType.isExactlyType(type) ||
        _hooksWidgetRef.isExactlyType(type);
  }

  static bool isRiverpodWidget(Element element) {
    return _riverpodWidgetChecker.isExactly(element);
  }

  static bool isBuildMethod(Element element) {
    if (element is! MethodElement) return false;
    return element.displayName == 'build';
  }

  /// target.watch(...), the target should be a subclass of Ref/WidgetRef
  /// target.read(...), the target should be a subclass of Ref/WidgetRef
  static bool isRiverpodTarget(Expression? target) {
    final targetType = target?.staticType;

    if (targetType == null) return false;

    final isRefType = isRef(targetType);

    return isRefType;
  }

  static bool checkIfLegacyProviderCreation(ArgumentList argumentList) {
    AstNode? ancestor = argumentList.parent;

    while (ancestor != null) {
      if (ancestor is InstanceCreationExpression) {
        final instanceType = ancestor.staticType;

        if (instanceType == null) return false;

        final isProviderCreation = isRiverpodProviderFromType(instanceType);

        return isProviderCreation;
      } else if (ancestor is FunctionExpressionInvocation) {
        final type = ancestor.staticInvokeType;
        if (type != null) {
          final isProvider = checkIfFamilyOrAutoDisposeProvider(type);

          if (isProvider) {
            return true;
          }
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

  static bool checkIfFamilyOrAutoDisposeProvider(DartType type) {
    if (type is! FunctionType) return false;
    final returnType = type.returnType;

    return isRiverpodProviderFromType(returnType) ||
        familyType.isAssignableFromType(returnType);
  }

  static bool checkIfHasRiverpodAnnotation(Element? ele) {
    if (ele == null) return false;

    final metadata = ele.metadata;

    return metadata.any(
      (e) {
        final name = e.element?.declaration?.getDisplayString();

        if (name == null) return false;

        return name.contains("riverpod") || name.contains("Riverpod");
      },
    );
  }

  static bool isRiverpodWidgetBuildMethod(MethodDeclaration method) {
    final element = method.declaredElement;

    if (element == null) return false;
    final params = element.parameters;

    if (!isBuildMethod(element) || params.length < 2) return false;

    final firstParam = params[0];
    final secondParam = params[1];

    final buildContext = firstParam.type.getDisplayString() == "BuildContext";
    final widgetRef = isWidgetRef(secondParam.type);

    return buildContext && widgetRef;
  }
}

const _providerChecker = TypeChecker.any([
  anyProviderType,
  anyStateProviderType,
  anyStateNotifierProviderType,
  anyFutureProviderType,
  anyStreamProviderType,
  anyAsyncNotifierProviderType,
  anyChangeNotifierProviderType,
]);

const _refChecker = TypeChecker.any([
  widgetRefType,
  refType,
  _hooksWidgetRef,
]);

const _riverpodWidgetChecker = TypeChecker.any([
  consumerWidgetType,
  hookConsumerWidgetType,
  consumerStatefulWidgetType,
  consumerStateType,
  statefulHookConsumerStateType,
]);

const _widgetChecker = TypeChecker.fromName("Widget", packageName: "flutter");
