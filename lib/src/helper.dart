import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:riverpod_analyzer_utils/riverpod_analyzer_utils.dart';

const _hooksWidgetRef =
    TypeChecker.fromName("WidgetRef", packageName: "hooks_riverpod");

class LintHelper {
  static bool isRiverpodProviderFromType(DartType type) {
    return _providerChecker.isExactlyType(type);
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

  static bool checkIfProviderCreation(ArgumentList argumentList) {
    final parent = argumentList.parent;

    if (parent == null || parent is! InstanceCreationExpression) return false;

    final instanceType = parent.staticType;

    if (instanceType == null) return false;

    final isProviderCreation = isRiverpodProviderFromType(instanceType);

    return isProviderCreation;
  }

  static bool checkIfWidgetFunction(NamedExpression namedExpression) {
    final type = namedExpression.staticType;
    if (type == null || type is! FunctionType) return false;
    final isWidget = _widgetChecker.isAssignableFromType(type.returnType);

    return isWidget;
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
