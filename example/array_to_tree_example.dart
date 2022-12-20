import 'dart:convert';

import 'package:array_to_tree/array_to_tree.dart';

void main() {
  final items = [
    TestClass(id: 1, parentId: null, children: [], title: 'title1'),
    TestClass(id: 2, parentId: null, children: [], title: 'title2'),
    TestClass(id: 3, parentId: 1, children: [], title: 'title3'),
    TestClass(id: 4, parentId: 1, children: [], title: 'title4'),
    TestClass(id: 5, parentId: 2, children: [], title: 'title5'),
    TestClass(id: 6, parentId: 2, children: [], title: 'title6'),
    TestClass(id: 7, parentId: 3, children: [], title: 'title7'),
  ];

  print(items);

  final tree = ArrayToTree.instance.toTree(items);

  print(tree);
}

class TestClass extends BaseEntity {
  final String title;
  const TestClass({
    required int id,
    required int? parentId,
    required List<TestClass> children,
    required this.title,
  }) : super(id: id, parentId: parentId, children: children);

  @override
  List<Object?> get props => [id, parentId, children, title];

  Map<String, dynamic> get toJson => {
        'id': id,
        'parentId': parentId,
        'title': title,
        'children': (children as List<TestClass>).map((e) => e.toJson).toList(),
      };

  @override
  String toString() => JsonEncoder.withIndent('  ').convert(toJson);

  @override
  Object withArray() => TestClass(
        id: id,
        parentId: parentId,
        children: [],
        title: title,
      );
}
