import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class HomeDrawer extends StatelessWidget {
  final nameVN = ValueNotifier<String>('');

  HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryColor.withAlpha(70),
            ),
            child: Row(
              children: [
                // Selector plucks a piece of information (selector) and pass it to the builder
                Selector<AuthProvider, String>(
                    selector: (context, authProvider) {
                  return authProvider.user?.photoURL ??
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLqXF4GuAikN2kXlM3kSXwiLuJvdFFHEYaEw&s';
                }, builder: (_, value, __) {
                  return CircleAvatar(
                    backgroundImage: NetworkImage(value),
                    radius: 30,
                  );
                }),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Selector<AuthProvider, String>(
                        selector: (context, authProvider) {
                      return authProvider.user?.displayName ?? 'Username';
                    }, builder: (_, value, __) {
                      return Text(
                        value,
                        style: context.textTheme.titleMedium,
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: const Text('Change name'),
                      content: TextField(
                        onChanged: (value) => nameVN.value = value,
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.red),
                            )),
                        TextButton(
                            onPressed: () async {
                              final nameValue = nameVN.value;
                              if (nameValue.isEmpty) {
                                Messages.of(context)
                                    .showError('Name is required!');
                              } else {
                                await context
                                    .read<UserService>()
                                    .updateDisplayName(nameValue);
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text('Change')),
                      ],
                    );
                  });
            },
            title: const Text('Change name'),
          ),
          ListTile(
            onTap: () => context.read<AuthProvider>().logout(),
            title: const Text('Exit'),
          ),
        ],
      ),
    );
  }
}
