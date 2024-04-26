import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';

abstract class TodoListModule {
  final Map<String, WidgetBuilder> _routes;
  final List<SingleChildWidget>? _bindings;

  TodoListModule({
    List<SingleChildWidget>? bindings,
    required Map<String, WidgetBuilder> routes,
  })  : _routes = routes,
        _bindings = bindings;

  Map<String, WidgetBuilder> get routes {
    return {};
  }
}
