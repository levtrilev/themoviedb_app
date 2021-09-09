import 'package:flutter/material.dart';

class PassDataToChild extends StatelessWidget {
  const PassDataToChild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: DataOwnerStatefull(),
      ),
    );
  }
}

class DataOwnerStatefull extends StatefulWidget {
  const DataOwnerStatefull({Key? key}) : super(key: key);

  @override
  _DataOwnerStatefullState createState() => _DataOwnerStatefullState();
}

class _DataOwnerStatefullState extends State<DataOwnerStatefull> {
  var _valueOne = 0;
  var _valueTwo = 0;
  void _incrementOne() {
    _valueOne += 1;
    setState(() {});
  }

  void _incrementTwo() {
    _valueTwo += 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 100,
        ),
        ElevatedButton(
          onPressed: _incrementOne,
          child: const Text('Жми раз'),
        ),
        ElevatedButton(
          onPressed: _incrementTwo,
          child: const Text('Жми два'),
        ),
        DataProviderInherited(
          valueOne: _valueOne,
          valueTwo: _valueTwo,
          child: const DataConsumerStateless(),
        ),
      ],
    );
  }
}

class DataConsumerStateless extends StatelessWidget {
  const DataConsumerStateless({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final valueOne = context
            .dependOnInheritedWidgetOfExactType<DataProviderInherited>(
                aspect: 'one')
            ?.valueOne ??
        0;
    // final value =
    //     context.findAncestorStateOfType<_DataOwnerStatefullState>()?._value ??
    //         0;
    // print('$value');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('$valueOne'),
        const DataConsumerStatefull(),
      ],
    );
  }
}

class DataConsumerStatefull extends StatefulWidget {
  const DataConsumerStatefull({Key? key}) : super(key: key);

  @override
  _DataConsumerStatefullState createState() => _DataConsumerStatefullState();
}

class _DataConsumerStatefullState extends State<DataConsumerStatefull> {
  @override
  Widget build(BuildContext context) {
    final valueTwo = context
            .dependOnInheritedWidgetOfExactType<DataProviderInherited>(
                aspect: 'two')
            ?.valueTwo ??
        0;
    // final valueTwo = context
    //         .findAncestorStateOfType<_DataOwnerStatefullState>()
    //         ?._valueTwo ??
    //     0;
    return Text('$valueTwo');
  }
}

class DataProviderInherited extends InheritedModel<String> {
  final int valueOne;
  final int valueTwo;
  const DataProviderInherited({
    Key? key,
    required Widget child,
    required this.valueOne,
    required this.valueTwo,
  }) : super(key: key, child: child);

  // final Widget child;

  // static DataProviderInherited? of(BuildContext context) {
  //   return context.dependOnInheritedWidgetOfExactType<DataProviderInherited>();
  // }

  @override
  bool updateShouldNotify(DataProviderInherited oldWidget) {
    return valueOne != oldWidget.valueOne || valueTwo != oldWidget.valueTwo;
  }

  @override
  bool updateShouldNotifyDependent(
      covariant DataProviderInherited oldWidget, Set<String> dependencies) {
    final oneIsUpdated =
        valueOne != oldWidget.valueOne && dependencies.contains('one');
    final twoIsUpdated =
        valueTwo != oldWidget.valueTwo && dependencies.contains('two');
    return oneIsUpdated || twoIsUpdated;
  }
}
