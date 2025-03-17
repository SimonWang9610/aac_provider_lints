import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:analyzer/error/error.dart' show ErrorSeverity;

const codePlaceholder = LintCode(
  name: 'avoid_riverpod_bad_practice',
  problemMessage: "Riverpod bad practices detected.",
  errorSeverity: ErrorSeverity.WARNING,
);

const refParamCode = LintCode(
  name: 'avoid_ref_parameter',
  problemMessage: "WidgetRef/Ref has lifecycle bound to provider/widgets.",
  errorSeverity: ErrorSeverity.WARNING,
  correctionMessage:
      "Using it in riverpod widgets/providers internally instead of passing it as a parameter."
      "Or make the method private if it is a method parameter to restrict its scope.",
);

const providerParamCode = LintCode(
  name: 'avoid_provider_parameter',
  problemMessage: "Bad riverpod provider practices detected.",
  errorSeverity: ErrorSeverity.WARNING,
  correctionMessage:
      "Create a global provider, and access it using WidgetRef/Ref inside Riverpod widgets/providers.",
);

const dynamicProviderCode = LintCode(
  name: 'avoid_create_dynamic_provider',
  problemMessage: 'Provider bad practices detected',
  errorSeverity: ErrorSeverity.WARNING,
  correctionMessage:
      "Either make it as a global provider and access it using WidgetRef/Ref inside Riverpod widgets/providers."
      "If it is only used inside this class, consider converting it as Listenable or internal variables.",
);

const refWatchCode = LintCode(
  name: "always_ref_watch_in_build_method",
  problemMessage: "Bad ref practices detected.",
  errorSeverity: ErrorSeverity.WARNING,
  correctionMessage:
      "User ref.read outside of build methods to avoid unnecessary re-build.",
);

const refReadCode = LintCode(
  name: "avoid_ref_read_in_build_method",
  problemMessage: "Bad ref practices detected.",
  errorSeverity: ErrorSeverity.WARNING,
  correctionMessage:
      "User ref.watch instead. If you did it purposely, consider moving the logic outside of build methods.",
);

const refInlineCode = LintCode(
  name: 'avoid_inline_provider_invocation',
  problemMessage: "Bad ref practices detected.",
  correctionMessage:
      "Declare a variable and assign the inline invocation to it,"
      " like `final providerValue = ref.watch(provider);` Or wrap the inline invocation in a function.",
);
