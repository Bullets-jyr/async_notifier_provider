import 'dart:async';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_provider.g.dart';

// FutureOr: Future<T> || T
// Future를 return한 경우와 그렇지 않은 경우 차이가 있습니다.
// class Counter extends AsyncNotifier<int> {
// class Counter extends AutoDisposeAsyncNotifier<int> {
// class Counter extends FamilyAsyncNotifier<int, int> {
// class Counter extends AutoDisposeFamilyAsyncNotifier<int, int> {
//   @override
//   Family: build(int arg) 추가 파라미터가 필요합니다.
//   FutureOr<int> build(int arg) async {
//     ref.onDispose(() {
//       print('[counterProvider] disposed');
//     });
//     await waitSecond();
//     return arg;
//   }
//   // @override
//   // FutureOr<int> build() {
//   //   ref.onDispose(() {
//   //     print('[counterProvider] disposed');
//   //   });
//   //   AsyncData state를 emit했습니다.
//   //   return 0; // CircularProgressIndicator 표시되지 않고 바로 0이 표시됩니다. AysncLoading()은 emit되지 않습니다.
//   //   return Future.value(0); // CircularProgressIndicator 표시되지 않고 바로 0이 표시됩니다. AysncLoading()은 emit되었습니다. (지연시간이 없어서)
//   // }

//   Future<void> waitSecond() => Future.delayed(const Duration(seconds: 1));

//   Future<void> increment() async {
//     state = const AsyncLoading();

//  guard = data + error
//     state = await AsyncValue.guard(() async {
//       await waitSecond();
//       // if (state.value! == 2) {
//       //   throw 'Fail to increment';
//       // }
//       return state.value! + 1;
//     });

//     // try {
//     //   await waitSecond();
//     //   // throw 'Fail to increment';
//     //   // AsyncValue는 이전 값을 기억합니다.
//     //   // 그 이전 값은 value property에 저장됩니다.
//     //   // state.value: state의 이전 데이터 값
//     //   state = AsyncData(state.value! + 1);
//     // } catch (error, stackTrace) {
//     //   state = AsyncError(error, stackTrace);
//     //   만약 stackTrace가 가용하지 않을 때, AsyncError를 state에 assign할 필요가 있다면, stackTrace.current를 넘겨주면됩니다.
//     //   state = AsyncError(error, stackTrace.current);
//     // }
//   }

//   Future<void> decrement() async {
//     state = const AsyncLoading();

//     state = await AsyncValue.guard(() async {
//       await waitSecond();
//       return state.value! - 1;
//     });

//     // try {
//     //   await waitSecond();
//     //   state = AsyncData(state.value! - 1);
//     // } catch (error, stackTrace) {
//     //   state = AsyncError(error, stackTrace.current);
//     // }
//   }
// }

// final counterProvider = AsyncNotifierProvider<Counter, int>(Counter.new);
// final counterProvider = AsyncNotifierProvider.autoDispose<Counter, int>(Counter.new);
// final counterProvider = AsyncNotifierProvider.family<Counter, int, int>(Counter.new);
// final counterProvider = AsyncNotifierProvider.autoDispose.family<Counter, int, int>(Counter.new);

// autodispose
@riverpod
class Counter extends _$Counter {
  // family
  @override
  FutureOr<int> build(int initialValue) async {
    ref.onDispose(() {
      print('[counterProvider] disposed');
    });
    await waitSecond();
    return initialValue;
  }

  Future<void> waitSecond() => Future.delayed(const Duration(seconds: 1));

  Future<void> increment() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await waitSecond();
      // if (state.value! == 2) {
      //   throw 'Fail to increment';
      // }
      return state.value! + 1;
    });

    try {
      await waitSecond();
      // throw 'Fail to increment';
      state = AsyncData(state.value! + 1);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> decrement() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await waitSecond();
      return state.value! - 1;
    });

    try {
      await waitSecond();
      state = AsyncData(state.value! - 1);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}