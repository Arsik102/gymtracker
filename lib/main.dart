import 'package:flutter/material.dart';
import 'package:gym_tracker1_0/data/workout_data.dart';
import 'package:gym_tracker1_0/pages/home_page.dart';
import 'package:gym_tracker1_0/pages/intro_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  // initalize hive
  await Hive.initFlutter();

  // open a hive box
  await Hive.openBox('workout_database1');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WorkoutData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const IntroPage(),
          '/home_page': (context) => const HomePage(),
        },
      ),
    );
  }
}