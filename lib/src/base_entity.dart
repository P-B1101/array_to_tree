part of array_to_tree;

/// Base Entity that subject class need to extends from.
/// need to override [BaseEntity.withArray] method and just put simple []
///  for [BaseEntity.children] parameter
///
/// extends from [Equatable] for equality purpose.
/// need to implement [Equatable.props]
abstract class BaseEntity extends Equatable {
  final int id;
  final int? parentId;
  final List<BaseEntity> children;

  const BaseEntity({
    required this.id,
    required this.parentId,
    this.children = const [],
  });

  Object withArray();
}
