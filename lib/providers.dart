import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_education/counter_demo.dart';

final appTitleProvider = Provider((ref) => "Riverpod Training");

final nameProvider = Provider((ref) => "Oguzhan PORTAKAL");

final counterProvider = StateProvider<int>((ref) => 0);

final counterStateNotifierProvider =
    StateNotifierProvider<CounterDemo, int>((ref) => CounterDemo());
