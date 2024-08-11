import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/activity.dart';
import '../../providers/dio_provider.dart';

part 'async_activity_provider.g.dart';

@riverpod
class AsyncActivity extends _$AsyncActivity {
  int _errorCounter = 0;

  @override
  FutureOr<Activity> build() {
    ref.onDispose(() {
      print('[asyncActivityProvider] disposed');
    });
    // AsyncNotifier build함수에서는 state를 async하게 initialize할 수 있습니다.
    return getActivity(activityTypes[0]);
  }

  Future<Activity> getActivity(String activityType) async {
    if (_errorCounter++ % 2 != 1) {
      await Future.delayed(const Duration(seconds: 1));
      throw 'Fail to fetch activity';
    }
    final response = await ref.read(dioProvider).get('?type=$activityType');
    final List activityList = response.data;
    return Activity.fromJson(activityList.first);
  }

  Future<void> fetchActivity(String activityType) async {
    // state = const AsyncLoading(); 이것도 가능합니다.
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      // if (_errorCounter++ % 2 != 1) {
      //   await Future.delayed(const Duration(seconds: 1));
      //   throw 'Fail to fetch activity';
      // }
      return getActivity(activityType);
    });
  }
}