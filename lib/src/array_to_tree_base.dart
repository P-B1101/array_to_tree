part of array_to_tree;

/// The [ArrayToTree] entry point.
///
/// To convert linear (flat) list to tree list, call [ArrayToTree.instance.toTree]
class ArrayToTree {
  /// private constructor
  ///
  ArrayToTree._();

  static final ArrayToTree _instance = ArrayToTree._();

  static ArrayToTree get instance => _instance;

  /// Generate tree with the type of `T`
  /// base on provided flat list with the same type.
  ///
  ///
  ///
  /// ```dart
  ///
  /// class TestClass extends BaseEntity {
  ///   final String title;
  ///   const TestClass({
  ///     required int id,
  ///     required int? parentId,
  ///     required List<TestClass> children,
  ///     required this.title,
  ///   }) : super(
  ///           id: id,
  ///           parentId: parentId,
  ///           children: children,
  ///         );
  ///   @override
  ///   Object withArray() => TestClass(
  ///         id: id,
  ///         parentId: parentId,
  ///         children: [],
  ///         title: title,
  ///       );
  ///
  ///   @override
  ///   List<Object?> get props => [id, parentId, children, title];
  /// }
  ///
  ///
  ///  final items = [
  ///    TestClass(id: 1, parentId: null, children: [], title: 'title1'),
  ///    TestClass(id: 2, parentId: null, children: [], title: 'title2'),
  ///    TestClass(id: 3, parentId: 1, children: [], title: 'title3'),
  ///    TestClass(id: 4, parentId: 1, children: [], title: 'title4'),
  ///    TestClass(id: 5, parentId: 2, children: [], title: 'title5'),
  ///    TestClass(id: 6, parentId: 2, children: [], title: 'title6'),
  ///    TestClass(id: 7, parentId: 3, children: [], title: 'title7'),
  ///  ];
  ///
  ///  final treeResult = ArrayToTree.instance.toTree(items);
  ///
  /// print(treeResult);
  ///
  /// final items[
  ///     TestClass(
  ///         id: 1,
  ///         parentId: null,
  ///         children: [
  ///           TestClass(
  ///             id: 3,
  ///             parentId: 1,
  ///             children: [
  ///               TestClass(id: 7, parentId: 3, children: [], title: 'title7'),
  ///             ],
  ///             title: 'title3',
  ///           ),
  ///           TestClass(id: 4, parentId: 1, children: [], title: 'title4'),
  ///         ],
  ///         title: 'title1'),
  ///     TestClass(
  ///         id: 2,
  ///         parentId: null,
  ///         children: [
  ///           TestClass(id: 5, parentId: 2, children: [], title: 'title5'),
  ///           TestClass(id: 6, parentId: 2, children: [], title: 'title6'),
  ///         ],
  ///         title: 'title2'),
  ///   ];
  /// ```
  List<T> toTree<T extends BaseEntity>(List<T> items) {
    List<T> treeList = [];
    Map<int, T> lookup = {};
    for (T item in items) {
      T newObj = item.withArray() as T;
      lookup[item.id] = newObj;
    }
    for (T obj in items) {
      if (obj.parentId != null) {
        lookup[obj.parentId]!.children.add(lookup[obj.id]!);
      } else {
        treeList.add(lookup[obj.id]!);
      }
    }

    return treeList;
  }
}
