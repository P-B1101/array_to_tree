import 'package:list_to_tree/list_to_tree.dart';
import 'package:test/test.dart';

class TestClass extends BaseEntity {
  final String title;
  const TestClass({
    required int id,
    required int? parentId,
    required List<TestClass> children,
    required this.title,
  }) : super(
          id: id,
          parentId: parentId,
          children: children,
        );

  @override
  Object withArray() => TestClass(
        id: id,
        parentId: parentId,
        children: [],
        title: title,
      );

  @override
  List<Object?> get props => [id, parentId, children, title];
}

void main() {
  group('test functionality', () {
    test('test for ordered with id list', () async {
      // arange
      final items = [
        TestClass(id: 1, parentId: null, children: [], title: 'title1'),
        TestClass(id: 2, parentId: null, children: [], title: 'title2'),
        TestClass(id: 3, parentId: 1, children: [], title: 'title3'),
        TestClass(id: 4, parentId: 1, children: [], title: 'title4'),
        TestClass(id: 5, parentId: 2, children: [], title: 'title5'),
        TestClass(id: 6, parentId: 2, children: [], title: 'title6'),
        TestClass(id: 7, parentId: 3, children: [], title: 'title7'),
      ];
      final expectedTree = [
        TestClass(
            id: 1,
            parentId: null,
            children: [
              TestClass(
                id: 3,
                parentId: 1,
                children: [
                  TestClass(id: 7, parentId: 3, children: [], title: 'title7'),
                ],
                title: 'title3',
              ),
              TestClass(id: 4, parentId: 1, children: [], title: 'title4'),
            ],
            title: 'title1'),
        TestClass(
            id: 2,
            parentId: null,
            children: [
              TestClass(id: 5, parentId: 2, children: [], title: 'title5'),
              TestClass(id: 6, parentId: 2, children: [], title: 'title6'),
            ],
            title: 'title2'),
      ];
      // act
      final result = ListToTree.instance.toTree(items);
      // assert
      expect(result, expectedTree);
    });

    test('test for unordered with id list', () async {
      // arange
      final items = [
        TestClass(id: 7, parentId: 3, children: [], title: 'title7'),
        TestClass(id: 1, parentId: null, children: [], title: 'title1'),
        TestClass(id: 6, parentId: 2, children: [], title: 'title6'),
        TestClass(id: 3, parentId: 1, children: [], title: 'title3'),
        TestClass(id: 5, parentId: 2, children: [], title: 'title5'),
        TestClass(id: 4, parentId: 1, children: [], title: 'title4'),
        TestClass(id: 2, parentId: null, children: [], title: 'title2'),
      ];
      final expectedTree = [
        TestClass(
          id: 1,
          parentId: null,
          children: [
            TestClass(
              id: 3,
              parentId: 1,
              children: [
                TestClass(
                  id: 7,
                  parentId: 3,
                  children: [],
                  title: 'title7',
                )
              ],
              title: 'title3',
            ),
            TestClass(
              id: 4,
              parentId: 1,
              children: [],
              title: 'title4',
            )
          ],
          title: 'title1',
        ),
        TestClass(
          id: 2,
          parentId: null,
          children: [
            TestClass(
              id: 6,
              parentId: 2,
              children: [],
              title: 'title6',
            ),
            TestClass(
              id: 5,
              parentId: 2,
              children: [],
              title: 'title5',
            ),
          ],
          title: 'title2',
        ),
      ];
      // act
      final result = ListToTree.instance.toTree(items);
      // assert
      expect(result, expectedTree);
    });
  });
}
