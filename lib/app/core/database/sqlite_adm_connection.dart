
import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/database/sqlite_connection_factory.dart';

class SqliteAdmConnection with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final connection = SqliteConnectionFactory();

    switch(state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.hidden:
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused: // When process is put on hold (eg. answering a call)
      case AppLifecycleState.detached: // When process is killed
        connection.closeConnection();
        break;
    }

    super.didChangeAppLifecycleState(state);
  }
}