import 'package:flutter/material.dart';

class NotifierProvider<Model extends ChangeNotifier> extends InheritedNotifier {
  final Model model;
  const NotifierProvider({
    Key? key,
    required this.model,
    required this.child,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );

  // ignore: annotate_overrides, overridden_fields
  final Widget child;

  static Model? watch<Model extends ChangeNotifier>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<NotifierProvider<Model>>()
        ?.model;
  }

  static Model? read<Model extends ChangeNotifier>(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<NotifierProvider<Model>>()
        ?.widget;
    return widget is NotifierProvider<Model> ? widget.model : null;
  }
}

class Provider<Model> extends InheritedWidget {
  final Model model;
  // ignore: annotate_overrides, overridden_fields
  final Widget child;
  const Provider({
    Key? key,
    required this.model,
    required this.child,
  }) : super(key: key, child: child);

  static Model? watch<Model>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<Provider<Model>>()
        ?.model;
  }

  static Model? read<Model>(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<Provider<Model>>()
        ?.widget;
    return widget is Provider<Model> ? widget.model : null;
  }

  @override
  bool updateShouldNotify(Provider oldWidget) {
    return model != oldWidget.model;
  }
}

// class AuthProvider extends InheritedNotifier {
//   final AuthModel model;
//   AuthProvider({
//     Key? key,
//     required this.model,
//     required this.child,
//   }) : super(
//           key: key,
//           notifier: model,
//           child: child,
//         );

//   final Widget child;

//   static AuthProvider? watch(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<AuthProvider>();
//   }

//   static AuthProvider? read(BuildContext context) {
//     final widget =
//         context.getElementForInheritedWidgetOfExactType<AuthProvider>()?.widget;
//     return widget is AuthProvider ? widget : null;
//   }
// }
