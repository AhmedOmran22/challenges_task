import 'package:flutter/material.dart';

import 'challenges/loading_animation_challenge.dart';
// import 'challenges/reordable_list_view_challenge.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoadingAnimationChallenge(),
    );
  }
}
