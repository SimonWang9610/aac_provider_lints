// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$watchOneHash() => r'cebad6ebd4dce5788dabd23a03ae7ab86c106dc7';

/// See also [WatchOne].
@ProviderFor(WatchOne)
final watchOneProvider = AutoDisposeNotifierProvider<WatchOne, int?>.internal(
  WatchOne.new,
  name: r'watchOneProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$watchOneHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WatchOne = AutoDisposeNotifier<int?>;
String _$watchTwoHash() => r'864dfcaaa55f7a59aafbe88f3b7cf5f62b360c04';

/// See also [WatchTwo].
@ProviderFor(WatchTwo)
final watchTwoProvider = AutoDisposeNotifierProvider<WatchTwo, int?>.internal(
  WatchTwo.new,
  name: r'watchTwoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$watchTwoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WatchTwo = AutoDisposeNotifier<int?>;
String _$familyWatchHash() => r'fb3758878fea85c3609f77c544941af3032ab4c0';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$FamilyWatch extends BuildlessAutoDisposeNotifier<int?> {
  late final Object? param;

  int? build(
    Object? param,
  );
}

/// See also [FamilyWatch].
@ProviderFor(FamilyWatch)
const familyWatchProvider = FamilyWatchFamily();

/// See also [FamilyWatch].
class FamilyWatchFamily extends Family<int?> {
  /// See also [FamilyWatch].
  const FamilyWatchFamily();

  /// See also [FamilyWatch].
  FamilyWatchProvider call(
    Object? param,
  ) {
    return FamilyWatchProvider(
      param,
    );
  }

  @override
  FamilyWatchProvider getProviderOverride(
    covariant FamilyWatchProvider provider,
  ) {
    return call(
      provider.param,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'familyWatchProvider';
}

/// See also [FamilyWatch].
class FamilyWatchProvider
    extends AutoDisposeNotifierProviderImpl<FamilyWatch, int?> {
  /// See also [FamilyWatch].
  FamilyWatchProvider(
    Object? param,
  ) : this._internal(
          () => FamilyWatch()..param = param,
          from: familyWatchProvider,
          name: r'familyWatchProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$familyWatchHash,
          dependencies: FamilyWatchFamily._dependencies,
          allTransitiveDependencies:
              FamilyWatchFamily._allTransitiveDependencies,
          param: param,
        );

  FamilyWatchProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.param,
  }) : super.internal();

  final Object? param;

  @override
  int? runNotifierBuild(
    covariant FamilyWatch notifier,
  ) {
    return notifier.build(
      param,
    );
  }

  @override
  Override overrideWith(FamilyWatch Function() create) {
    return ProviderOverride(
      origin: this,
      override: FamilyWatchProvider._internal(
        () => create()..param = param,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        param: param,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<FamilyWatch, int?> createElement() {
    return _FamilyWatchProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FamilyWatchProvider && other.param == param;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, param.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FamilyWatchRef on AutoDisposeNotifierProviderRef<int?> {
  /// The parameter `param` of this provider.
  Object? get param;
}

class _FamilyWatchProviderElement
    extends AutoDisposeNotifierProviderElement<FamilyWatch, int?>
    with FamilyWatchRef {
  _FamilyWatchProviderElement(super.provider);

  @override
  Object? get param => (origin as FamilyWatchProvider).param;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
