import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Selector<AuthProvider, String>(
          selector: (context, authProvider) =>
              authProvider.user?.displayName ?? 'Username',
          builder: (_, value, __) {
            return Text(
              'Hey, $value!',
              style: context.textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            );
          }),
    );
  }
}
