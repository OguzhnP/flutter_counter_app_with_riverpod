import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:riverpod_education/counter_demo.dart';
import 'package:riverpod_education/providers.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: Grock.navigationKey,
        scaffoldMessengerKey: Grock.scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        title: appTitleProvider.toString(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.read(nameProvider);
    final count = ref.watch(counterProvider);
    final countNotifier = ref.watch(counterStateNotifierProvider);
    ref.listen(counterStateNotifierProvider, (previous, next) {
      if (next % 5 == 0) {
        Grock.snackBar(
            duration: const Duration(seconds: 2),
            leading: const Icon(
              CupertinoIcons.checkmark,
              color: Colors.black,
            ),
            title: "Congrats",
            description: "Count is $next ",
            position: SnackbarPosition.bottom);
      }
    });
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Colors.black,
        middle: const Text(
          "Riverpod Training",
          style: TextStyle(color: Colors.white),
        ),
        trailing: IconButton(
            onPressed: () {
              //  ref.invalidate(counterProvider);
              // ref.refresh(coounterProvider);
              ref.invalidate(counterStateNotifierProvider);
            },
            icon: const Icon(
              CupertinoIcons.refresh_bold,
              color: Colors.white,
              size: 25,
            )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name),
            Text(
              // count.toString(),
              countNotifier.toString(),
              style: const TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          // ref.read(coounterProvider.notifier).state++;
          // ref.read(counterProvider.notifier).update((state) => state + 1);
          ref.read(counterStateNotifierProvider.notifier).increment();
        },
        child: const Icon(
          CupertinoIcons.add,
        ),
      ),
    );
  }
}
