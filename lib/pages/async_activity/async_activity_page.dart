import 'dart:math';

import 'package:bulleted_list/bulleted_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/activity.dart';
import 'async_activity_provider.dart';

class AsyncActivityPage extends ConsumerWidget {
  const AsyncActivityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityState = ref.watch(asyncActivityProvider);
    print(activityState);
    print('isLoading: ${activityState.isLoading}, isRefreshing: ${activityState.isRefreshing}, isReloading: ${activityState.isReloading}');
    print('hasValue: ${activityState.hasValue}, hasError: ${activityState.hasError}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('AsyncActivityProvider'),
      ),
      body: activityState.when(
        data: (activity) => ActivityWidget(activity: activity),
        error: (e, st) => Center(
          child: Text(
            e.toString(),
            style: const TextStyle(
              fontSize: 20,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final randomNumber = Random().nextInt(activityTypes.length);
          ref
              .read(asyncActivityProvider.notifier)
              .fetchActivity(activityTypes[randomNumber]);
        },
        label: Text(
          'New Activity',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}

class ActivityWidget extends StatelessWidget {
  const ActivityWidget({
    Key? key,
    required this.activity,
  }) : super(key: key);

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Text(
            activity.type,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Divider(),
          BulletedList(
            bullet: const Icon(
              Icons.check,
              color: Colors.green,
            ),
            listItems: [
              'activity: ${activity.activity}',
              'accessibility: ${activity.accessibility}',
              'participants: ${activity.participants}',
              'price: ${activity.price}',
              'key: ${activity.key}',
            ],
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}