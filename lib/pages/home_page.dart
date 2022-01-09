import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/user_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(usersProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Users'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => await ref.refresh(usersProvider),
        child: users.when(
          data: (list) {
            final newList = ref.watch(filteredAndSortedUsersProvider(list));
            if (newList.isEmpty) {
              return const Center(child: Text('There is no user'));
            }
            return ListView.builder(
              itemCount: newList.length,
              itemBuilder: (_, i) {
                final user = newList[i];
                return ListTile(
                  minVerticalPadding: 25,
                  leading: Image.network(user.avatar),
                  title: Text('${user.firstName} ${user.lastName}'),
                  trailing: Text(user.role.name),
                );
              },
            );
          },
          error: (_, __) => const Center(child: Text('err')),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer(
                builder: (_, ref, __) {
                  final sort = ref.watch(sortProvider.state);
                  return ElevatedButton(
                    onPressed: () {
                      if (sort.state == Sort.reversed) {
                        sort.state = Sort.normal;
                      } else {
                        sort.state = Sort.reversed;
                      }
                    },
                    child: Text(
                      sort.state == Sort.normal
                          ? 'sort reversed'
                          : 'sort normal',
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer(
                builder: (_, ref, __) {
                  final filter = ref.watch(filterProvider.state);
                  return ElevatedButton(
                    onPressed: () {
                      if (filter.state == Role.admin) {
                        filter.state = Role.none;
                      } else {
                        filter.state = Role.admin;
                      }
                    },
                    child: Text(
                      filter.state == Role.admin
                          ? 'remove filter'
                          : 'filter admins',
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
