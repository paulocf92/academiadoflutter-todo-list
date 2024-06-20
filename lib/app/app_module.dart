import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/app_widget.dart';
import 'package:todo_list_provider/app/core/database/sqlite_connection_factory.dart';
import 'package:todo_list_provider/app/repositories/user/user_repository.dart';
import 'package:todo_list_provider/app/repositories/user/user_repository_impl.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';
import 'package:todo_list_provider/app/services/user/user_service_impl.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Add FirebaseAuth instance as a Provider to the app
        Provider(create: (_) => FirebaseAuth.instance),
        Provider(
          create: (_) => SqliteConnectionFactory(),
          lazy: false,
        ),

        // 1. Use context.read() to recover the FirebaseAuth instance attached above
        // 2. Pass the interface between <> and use its implementation, effectively typing this provider
        Provider<UserRepository>(
          create: (context) => UserRepositoryImpl(firebaseAuth: context.read()),
        ),
        // Same as above
        Provider<UserService>(
          create: (context) => UserServiceImpl(userRepository: context.read()),
        ),
      ],
      child: AppWidget(),
    );
  }
}
