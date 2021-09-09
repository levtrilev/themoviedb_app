import 'package:flutter/material.dart';

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  var ints = List<String>.generate(10, (index) => index.toString());
  void _onReorder(int from, int to) {
    if (from < to) {
      to -= 1;
    }
    final element = ints.removeAt(from);
    ints.insert(to, element);
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      itemCount: ints.length,
      itemBuilder: (context, index) {
        return GreenBox(
          key: ValueKey(ints[index]),
        );
      },
      onReorder: _onReorder,
    );
  }
}

class GreenBox extends StatefulWidget {
  const GreenBox({Key? key}) : super(key: key);

  @override
  _GreenBoxState createState() => _GreenBoxState();
}

class _GreenBoxState extends State<GreenBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.green,
        height: 100,
        child: const Padding(
          padding: EdgeInsets.all(18.0),
          child: TextField(),
          // child: Text('data'),
        ),
      ),
    );
  }
}
